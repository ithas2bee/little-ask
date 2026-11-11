import { Type } from 'class-transformer';
import { IsDefined, IsInt, Min } from 'class-validator';

export class ValidationExampleDto {
  @IsDefined()
  @Type(() => Number)
  @IsInt()
  @Min(1)
  quantity!: number;
}
