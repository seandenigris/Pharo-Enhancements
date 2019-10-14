## Useful enhancements to Pharo's core

### Features (just starting, most undocumented)

#### FileLocator - User-Configurable Origins
Just like we have `FileLocator home`, you can now have `FileLocator myProjectFolder`. There are two easy steps.

First, tell FileLocator about your new origin:
```smalltalk
FileLocator class >> #myProjectFolder
	^ self origin: #myProjectFolder
```

Then, tell `PeDynamicFSResolver` how to turn that label into a real FS object.
```smalltalk
PeDynamicFSResolver >> #myProjectFolder
	<supportedOrigin>
	
	^ '/Users/me/myProjectFolder/' asFileReference
```


#### Create Baseline - Two Easy Ways

- If you have a ConfigurationOf, convert/promote one of it's baseline methods into a full BaselineOf class via `ConfigurationOfMyProject createBaselineFrom: #baselineMethod`
- Starting with an RPackage, create a new BaselineOf including that package via `anRPackage createBaselineOf`
