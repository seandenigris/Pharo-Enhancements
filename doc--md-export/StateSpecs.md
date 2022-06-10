# StateSpecs


Custom  messages

1. Subclass [SpecOfShouldExpression](https://github.com/dionisiydk/StateSpecs/blob/master//StateSpecs-DSL-ShouldExpressions/SpecOfShouldExpression.class.st)
2. Attach it to your domain object by redefining [GHObjectGhost>>#should](https://github.com/dionisiydk/StateSpecs/blob/master//StateSpecs-GhostSupport/GHTMinimalGhost.extension.st). It might seem that you'd implement it like this, mirroring the default implementation:
```smalltalk
MyDomainObject>>#should
	^ MyCustomShouldSpec startingAt: self
```
        - However, that actually returns the default due to the global [SpecOfShouldExpression class>>#currentExpressionsClass](https://github.com/dionisiydk/StateSpecs/blob/master//StateSpecs-DSL-ShouldExpressions/SpecOfShouldExpression.class.st) setting. This surprising discovery has been reported (workaround in issue description:
dionisiydk/StateSpecs/issues/31
    - An example from Pillar is `PRDocumentItemShouldSpec>>#equalPillarMarkup:`
