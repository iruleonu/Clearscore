# Clearscore

Follows the same project structure as [IRShowcase](https://github.com/iruleonu/IRShowcase). 

## Uses

* Swift
* Combine
* SwiftyMocky
* ios-snapshot-test-case

## Getting started

### Install [Carthage](https://github.com/Carthage/Carthage#installing-carthage) and run:

```
carthage bootstrap --platform ios --use-ssh --new-resolver --cache-builds
```


### To auto-generate code for unit tests: [SwiftyMocky](https://github.com/MakeAWishFoundation/SwiftyMocky/blob/develop/guides/Installation.md#2-carthage):
Run the script get_sourcery.sh on the root of the project and then sourcery --config mocky.yml
If any problems, download latest binary from https://github.com/krzysztofzablocki/Sourcery/releases/

```
chmod +x get_sourcery.sh
./get_sourcery.sh
./Sourcery/bin/sourcery --config mocky.yml
```
