abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {}

abstract class BaseViewModelInputs {
  void start(
      //TODO : BRING DATA FROM MODEL
      );

  void dispose();
}

mixin BaseViewModelOutputs {}
