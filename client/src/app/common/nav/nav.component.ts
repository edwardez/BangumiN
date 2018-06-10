import {Component, Input, OnDestroy, OnInit} from '@angular/core';
import {SidenavService} from '../../shared/services/sidenav.service';
import {AuthenticationService} from '../../shared/services/auth.service';
import {filter, take,} from 'rxjs/operators';
import {StorageService} from '../../shared/services/storage.service';
import {BangumiUser} from '../../shared/models/BangumiUser';
import {concat} from 'rxjs';
import {BangumiUserService} from '../../shared/services/bangumi/bangumi-user.service';
import {ActivatedRoute, Router} from '@angular/router';
import {DeviceWidth} from '../../shared/enums/device-width.enum';
import {LayoutService} from '../../shared/services/layout/layout.service';
import {Subject} from 'rxjs/index';

@Component({
  selector: 'app-nav',
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.scss']
})
export class NavComponent implements OnInit, OnDestroy {
  bangumiUser: BangumiUser;
  searchKeywords = '';

  private ngUnsubscribe: Subject<void> = new Subject<void>();

  @Input()
  private currentDeviceWidth: DeviceWidth;


  constructor(private sidenavService: SidenavService,
              private storageService: StorageService,
              private authService: AuthenticationService,
              private bangumiUserService: BangumiUserService,
              private route: ActivatedRoute,
              private router: Router,
              private layoutService: LayoutService) {
    // initialize a dummy user
    this.bangumiUser = new BangumiUser().deserialize({
      id: '',
      avatar: {
        large: 'https://lain.bgm.tv/pic/user/l/icon.jpg',
        medium: 'https://lain.bgm.tv/pic/user/m/icon.jpg',
        small: 'https://lain.bgm.tv/pic/user/s/icon.jpg'
      },
      nickname: '',
      username: ''
    });


  }

  ngOnInit() {
    this.updateSearchBarText();
    this.updateUserInfo();

  }

  ngOnDestroy(): void {
    this.ngUnsubscribe.next();
    this.ngUnsubscribe.complete();
  }

  /**
   * this function will update text in search bar according to route params
   */
  updateSearchBarText() {
    this.route
      .queryParams
      .pipe(
        filter(params => params['keywords'] !== undefined)
      ).subscribe(
      params => {
        this.searchKeywords = decodeURI(params['keywords']);
      }
    );
  }

  /**
   ** we retrieve relevant user info here, we'll subscribe to first two user info service, and they must be non-null
   ** why two? because
   ** 1. the first value is from localStorage (to ensure speed)
   ** 2. the second value is from http service (slower, and user might change their avatar on computer A, after
   ** that they expect to see new avatar on computer B after refreshing)
   ** in more complicated cases, takeUntil should be used
   */

  updateUserInfo() {
    const userInfoServiceArray = [this.storageService.getBangumiUser(), this.bangumiUserService.getUserInfo()];


    concat.apply(this, userInfoServiceArray)
      .pipe(
        take(userInfoServiceArray.length),
        filter(bangumiUser => !!bangumiUser),
      )
      .subscribe(bangumiUser => {
        this.bangumiUser = bangumiUser;
        this.authService.userSubject.next(bangumiUser);
      });
  }

  toggleSidenav() {
    this.sidenavService
      .toggle()
      .then(() => {
      });

  }

  doFullSearch(query: string) {
    this.router.navigate(['/search'], {queryParams: {keywords: encodeURI(query)}});
  }

  get LayoutService() {
    return LayoutService;
  }
}
