const cliLogger = require('cli-logger')
const fs = require('fs')
const { enforceOrThrow } = require('./util')

const logger = cliLogger({ level: 'info' })

// Contstants
const BUILD_PATH = "./abigenBindings/";
const ABI_PATH = BUILD_PATH + "abi/"
const BIN_PATH = BUILD_PATH + "bin/"

module.exports = async (config) => {
    const options = parseConfig(config)
    createDirectories(options);   
    // Set debug logging
    if (config.debug) logger.level('debug')
    logger.debug('DEBUG logging is turned ON')
    
    let contracts= [];
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
    contracts.forEach(contract => writeAbigen(contract.contractName, contract.abi, contract.bytecode));
}

const parseImports = (options, blob) => {
    split = blob.source.split(";")
    let imports = [];
    split.forEach(line => {
        if(line.indexOf("import") > -1) {
            let path = line.split("import")[1].replace(/['"]+/g, '').replace(" ","");
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

    return {
        workingDir,
        contractsBuildDir,
        contracts
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
    logger.info("here")
    files.forEach(file => {
        const contractName = file.split(".")[0];
        const artifact = getArtifact(contractName, options);
        logger.info(artifact)
        if (artifact.abi.length !== 0) {
            content.push(artifact);
        }
    });
    return content;
}

const createDirectories = () => {
    try {
        fs.rmdirSync(BUILD_PATH, { recursive: true });
        fs.mkdirSync(BUILD_PATH);
        fs.mkdirSync(ABI_PATH);
        fs.mkdirSync(BIN_PATH);
    } catch (e) {
        logger.error(e)
    }
}

const writeAbigen = (contractName, abi, bytecode) => {
    bytecode = bytecode.substring(2);
    fs.writeFileSync(ABI_PATH + contractName + ".abi", JSON.stringify(abi))
    fs.writeFileSync(BIN_PATH + contractName + ".bin", bytecode)
}