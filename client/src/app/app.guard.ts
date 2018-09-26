import {Injectable} from '@angular/core';
import {ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot} from '@angular/router';
import {Observable} from 'rxjs';
import {AuthenticationService} from './shared/services/auth.service';
import {map} from 'rxjs/operators';
import {StorageService} from './shared/services/storage.service';

@Injectable({
  providedIn: 'root'
})
export class AppGuard implements CanActivate {

  constructor(
    private authService: AuthenticationService,
    private router: Router,
    private storageService: StorageService
  ) {
  }

  canActivate(
    next: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean> | Promise<boolean> | boolean {

    return this.authService.isAuthenticated().pipe(
      map(isAuthenticated => {
        if (isAuthenticated) {
          return true;
        }

        // else user is not authenticated, clear storage and redirect
        this.storageService.clear();
        this.router.navigate(['/login']);
        return false;
      })
    );


  }
}
