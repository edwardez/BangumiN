# Html parser naming convention:

* Expose top level method, all methods that parse sub element should be non `pubic` or
`@VisibleForTesting`

* Name top level method as `processXXXXXX`