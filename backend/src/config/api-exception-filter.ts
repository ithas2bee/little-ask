import {
  ArgumentsHost,
  Catch,
  HttpException,
  HttpStatus,
  type ExceptionFilter,
  type INestApplication,
} from '@nestjs/common';

interface ApiErrorResponse {
  statusCode: number;
  code: string;
  message: string;
}

@Catch()
export class ApiExceptionFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost): void {
    const statusCode =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    const response = this.createErrorResponse(statusCode);
    host.switchToHttp().getResponse().status(statusCode).json(response);
  }

  private createErrorResponse(statusCode: number): ApiErrorResponse {
    switch (statusCode) {
      case HttpStatus.BAD_REQUEST:
        return {
          statusCode,
          code: 'VALIDATION_ERROR',
          message: 'Request validation failed',
        };
      case HttpStatus.NOT_FOUND:
        return {
          statusCode,
          code: 'NOT_FOUND',
          message: 'Resource not found',
        };
      case HttpStatus.CONFLICT:
        return {
          statusCode,
          code: 'CONFLICT',
          message: 'Request conflicts with the current state',
        };
      case HttpStatus.INTERNAL_SERVER_ERROR:
        return {
          statusCode,
          code: 'INTERNAL_SERVER_ERROR',
          message: 'Internal server error',
        };
      default:
        return {
          statusCode,
          code: 'HTTP_ERROR',
          message: 'Request could not be completed',
        };
    }
  }
}

export function configureApiErrorHandling(app: INestApplication): void {
  app.useGlobalFilters(new ApiExceptionFilter());
}
