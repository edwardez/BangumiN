### Playbook

* How to handle redux error and send them back to Widget?
  
  Unfortunately currently there is no such widely accepted best practice to handle this issue.
  So far, the best way seems to be(considering reducing boiler plate / maintainability, but sacrificing some flexibility):
  1. Initialize a `Completer` for evert request action
  2. At the end of each action(i.e. end in the epic, or if necessary, end in the reducer), `complete`
  the `Completer`, or `completeError` if an error is thrown.
  3. In the code, now widget gets informed an error is occlude, do what ever you want.
  4. You can use `RequestInProgressIndicatorWidget`, which contains logic to handle most
  common error handling cases. It specially useful for `Get` request.
  5. Or you can send the error through `HandleErrorAction`, let relevant epic handle it.
  
  
* Naming convention

  All reducers, actions, epics..etc should end with  `xxxReduer`/`xxxAction`/`xxxEpic`
  
* Store

  All variables in store must use `built_value`, otherwise it simply won't work.