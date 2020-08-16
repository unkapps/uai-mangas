import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { AuthService } from './auth.service';

@Injectable()
export class FirebaseAuthGuard implements CanActivate {
  constructor(protected authService: AuthService) { }

  async canActivate(
    context: ExecutionContext,
  ): Promise<boolean> {
    const request = context.switchToHttp().getRequest();
    const tokenId = request.headers['token-id'] ?? null;
    const userId = await this.authService.getUserId(tokenId);

    request.userId = userId;

    return userId != null;
  }
}
