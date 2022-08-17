const cliLogger = require('cli-logger')
const fs = require('fs')
const {enforceOrThrow} = require('./util')

const logger = cliLogger({level: 'info'})

// Globals
let BUILD_PATH, ABI_PATH, BIN_PATH;

module.exports = async (config) => {
    const options = parseConfig(config)
    createDirectories(options);
    // Set debug logging
    if (config.debug) logger.level('debug')
    logger.debug('DEBUG logging is turned ON')

    let contracts = [];
    if (options.contracts.length === 0) {
        contracts = await getAllArtifacts(options);
    } else {
        for (const contractName of options.contracts) {
            const c = getArtifact(contractName, options);
            const importedContracts = parseImports(options, c);
            contracts.push(c);
            importedContracts.forEach(x => contracts.push(x));
        }
    }
    contracts.forEach(contract => writeAbigen(contract.contractName, contract.abi, contract.bytecode, options));
}

const parseImports = (options, blob) => {
    split = blob.source.split(";")
    let imports = [];
    split.forEach(line => {
        if (line.indexOf("import") > -1) {
            let path = line.split("import")[1].replace(/['"]+/g, '').replace(" ", "");
            let split = path.split("/");
            let name = split[split.length - 1].replace(".sol", "");
            imports.push(getArtifact(name, options));
        }
    })
    return imports
}

const parseConfig = (config) => {
    let contracts = [];
    if (config._.length > 1) {
        contracts = config._.slice(1);
        logger.info("Contracts supplied!")
    } else {
        logger.info("No contracts supplied, generating bindings for all built contracts.")
    }

    const workingDir = config.working_directory
    const contractsBuildDir = config.contracts_build_directory
    const exportDir = typeof config.abigen?.exportFolder == "string" ? config.abigen.exportFolder : "./abigenBindings/"
    const extension = typeof config.abigen?.extensionAbi == "string" ? config.abigen.extensionAbi : ".abi"
    const bingen = typeof config.abigen?.generateBin == "boolean" ? config.abigen.generateBin : true
    const exportConsole = typeof config.abigen?.exportConsole == "boolean" ? config.abigen.exportConsole : false

    return {
        workingDir,
        contractsBuildDir,
        contracts,
        exportDir,
        extension,
        bingen,
        exportConsole
    }
}

const getArtifact = (contractName, options) => {
    // Construct artifact path and read artifact
    let artifactPath = `${options.contractsBuildDir}/${contractName}.json`
    logger.debug(`Reading artifact file at ${artifactPath}`)
    enforceOrThrow(fs.existsSync(artifactPath), `Could not find ${contractName} artifact at ${artifactPath}`)
    // Stringify + parse to make a deep copy (to avoid bugs with PR #19)
    return JSON.parse(JSON.stringify(require(artifactPath)))
}

const getAllArtifacts = async (options) => {
    let files = fs.readdirSync("./build/contracts");
    const content = [];
    files.forEach(file => {
        const contractName = file.split(".")[0];
        const artifact = getArtifact(contractName, options);
        if (artifact.abi.length !== 0) {
            content.push(artifact);
        }
    });
    return content;
}

const createDirectories = (options) => {
    BUILD_PATH = options.exportDir;
    ABI_PATH = BUILD_PATH + "abi/";
    BIN_PATH = BUILD_PATH + "bin/";
    try {
        fs.existsSync(BUILD_PATH) && fs.rmdirSync(BUILD_PATH, {recursive: true});
        !fs.existsSync(BUILD_PATH) && fs.mkdirSync(BUILD_PATH, {recursive: true});
        !fs.existsSync(ABI_PATH) && fs.mkdirSync(ABI_PATH);
        options.bingen && fs.mkdirSync(BIN_PATH);
    } catch (e) {
        logger.error(e)
    }
}

const writeAbigen = (contractName, abi, bytecode, options) => {
    bytecode = bytecode.substring(2);
    fs.writeFileSync(ABI_PATH + contractName + options.extension, JSON.stringify(abi))
    options.bingen && fs.writeFileSync(BIN_PATH + contractName + ".bin", bytecode)
    options.exportConsole && logger.info(abi);
}