import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { AuthService } from './auth.service';
import { FirebaseAuthGuard } from './firebase-auth.guard';

@Injectable()
export class FirebaseAuthOptionalGuard extends FirebaseAuthGuard {
  constructor(protected authService: AuthService) { super(authService); }

  async canActivate(
    context: ExecutionContext,
  ): Promise<boolean> {
    await super.canActivate(context);

    return true;
  }
}
