sealed class ResponseWrapper {}

class SuccessWrapper implements ResponseWrapper {
  SuccessWrapper({required this.data});

  final dynamic data;

}

class ErrorWrapper implements ResponseWrapper {
  ErrorWrapper({required this.errorResponse});

  final ResponseError errorResponse;
}

class ResponseError {

  ResponseError({required this.errorMessage, this.errorTag});

  final String errorMessage;
  final String? errorTag;

}
