# truffle-plugin-abigen

This truffle plugin generates the required files needed to use Geths [abigen](https://github.com/ethereum/go-ethereum/wiki/Native-DApps:-Go-bindings-to-Ethereum-contracts) to generate contract bindings in golang.

## Installation
1. Install the plugin with npm
    ```sh
    npm install @chainsafe/truffle-plugin-abigen
    ```
2. Add the plugin to your `truffle.js` or `truffle-config.js` file
    ```js
    module.exports = {
      /* ... rest of truffle-config */

      plugins: [
        "@chainsafe/truffle-plugin-abigen"
      ]
    }
    ```

## Usage
Before running ensure that you've compiled your contracts:
```sh
truffle compile
```
To generate specific contract bindings:
```sh
truffle run abigen SomeContractName AnotherContractName
```
Alternatively, to generate bindings for all your contracts:
```sh
truffle run abigen
```

### Debugging
You can pass an optional `--debug` flag into the plugin to display debug messages during the verification process. This is generally not necessary, but can be used to provide additional information when the plugin appears to malfunction.