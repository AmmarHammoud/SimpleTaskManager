abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginSuccessState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginErrorState extends LoginStates{}

class ShownPassword extends LoginStates{}

class NotShownPassword extends LoginStates{}

class ChangingText extends LoginStates{}

class ChangedText extends LoginStates{}