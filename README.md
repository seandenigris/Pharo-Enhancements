## Useful enhancements to Pharo's core

### Features (just starting, most undocumented)

#### Create Baseline - Two Easy Ways

- If you have a ConfigurationOf, convert/promote one of it's baseline methods into a full BaselineOf class via `ConfigurationOfMyProject createBaselineFrom: #baselineMethod`
- Starting with an RPackage, create a new BaselineOf including that package via `anRPackage createBaselineOf`
