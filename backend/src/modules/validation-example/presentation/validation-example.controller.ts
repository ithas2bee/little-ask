import { Body, Controller, Post } from '@nestjs/common';
import { ValidationExampleUseCase } from '../application/validation-example.use-case';
import { ValidationExampleDto } from './validation-example.dto';

@Controller('validation-example')
export class ValidationExampleController {
  constructor(private readonly validationExample: ValidationExampleUseCase) {}

  @Post()
  execute(@Body() request: ValidationExampleDto): { quantity: number } {
    return this.validationExample.execute(request.quantity);
  }
}
