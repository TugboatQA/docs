---
title: "How to find Tugboat IDs"
date: 2019-09-26T15:23:53-04:00
weight: 4
---

## How to find Tugboat IDs

Whether you're reaching out to support or working in the Tugboat CLI, sometimes you'll need to know a Tugboat ID.

- [Find Tugboat IDs in the web interface](#in-the-tugboat-web-interface)
- [Find Tugboat IDs in the CLI](#in-the-tugboat-cli)

### In the Tugboat web interface:

- [Project ID](#project-id-in-the-web-interface)
- [Repository ID](#repository-id-in-the-web-interface)
- [Preview ID](#preview-id-in-the-web-interface)
- [Service ID](#service-id-in-the-web-interface)

#### Project ID in the web interface

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
2. Select the project whose ID you want to know.
3. Look in the address bar for the project ID; it's everything following tugboat.qa/ - i.e.
   tugboat.qa/**5e3c40e79366b1c43a153f38**.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project whose ID you want to know.

![Select the project](/_images/select-a-project.png)

Look in the address bar for the project ID; it's everything following tugboat.qa/ - i.e.
tugboat.qa/**5e3c40e79366b1c43a153f38**.

![Project ID in address bar](/_images/tugboat-project-id.png)

{{% /expand%}}

#### Repository ID in the web interface

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
2. Select the project that contains the repository whose ID you want to know.
3. Click into the repository whose ID you want to know.
4. Look in the address bar for the repository ID; it's everything following tugboat.qa/ - i.e.
   tugboat.qa/**5e3c414e9366b1d9e1154334**.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project that contains the repository whose ID you want to know.

![Select the project](/_images/select-a-project.png)

Click into the repository whose ID you want to know.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Look in the address bar for the repository ID; it's everything following tugboat.qa/ - i.e.
tugboat.qa/**5e3c414e9366b1d9e1154334**.

![Repository ID in address bar](/_images/repository-id-in-address-bar.png)

{{% /expand%}}

#### Preview ID in the web interface

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
2. Select the project that contains the Preview whose ID you want to know.
3. Click the name of the repo that contains the Preview whose ID you want to know.
4. Click into the Preview's name, and look in the address bar for the Preview ID; it's everything following
   tugboat.qa/ - i.e. tugboat.qa/**5e3c415d9366b17547154387**.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project that contains the Preview whose ID you want to know.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains the Preview whose ID you want to know.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Click into the Preview's name.

![Click into Preview name](/_images/click-into-preview-name.png)

Look in the address bar for the Preview ID; it's everything following tugboat.qa/ - i.e.
tugboat.qa/**5e3c415d9366b17547154387**.

![Preview ID in the address bar](/_images/preview-id-in-address-bar.png)

{{% /expand%}}

#### Service ID in the web interface

1. Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.
2. Select the project that contains the Preview whose service ID you want to know.
3. Click the name of the repo that contains the Preview whose service ID you want to know.
4. Click into the name of the Preview that contains the service whose ID you want to know.
5. Click into the service and look in the address bar for the service ID; it's everything following tugboat.qa/ - i.e.
   tugboat.qa/**5e3c415e7b9f1ce8aa1c0856**.

{{%expand "Visual Walkthrough" %}}

Go to username -> [My Projects](https://dashboard.tugboat.qa/projects) at the upper-right of the Tugboat screen.

![Go to username -> My Projects](/_images/go-to-user-my-projects.png)

Select the project that contains the Preview whose service ID you want to know.

![Select the project](/_images/select-a-project.png)

Click the name of the repo that contains the Preview whose service ID you want to know.

![Click into Tugboat repository](/_images/click-into-tugboat-repository.png)

Click into the name of the Preview that contains the service whose ID you want to know.

![Click into Preview name](/_images/click-into-preview-name.png)

Click into the service whose ID you want to know.

![Click into the service](/_images/click-into-service-name.png)

Look in the address bar for the service ID; it's everything following tugboat.qa/ - i.e.
tugboat.qa/**5e3c415e7b9f1ce8aa1c0856**.

![Service ID in the address bar](/_images/service-id-in-address-bar.png)

{{% /expand%}}

### In the Tugboat CLI:

With the [Tugboat CLI installed](/tugboat-cli/install-the-cli/), you can find IDs using a combination of commands and
args.

- [Project ID](#project-id-in-the-cli)
- [Repository ID](#repository-id-in-the-cli)
- [Preview ID](#preview-id-in-the-cli)
- [Service ID](#service-id-in-the-cli)

#### Project ID in the CLI

To find a project ID in Tugboat:

```sh
tugboat ls projects
```

You'll see a response similar to this:

```sh
Project ID                Sleep  Base  Quota  Size      Name
------------------------  -----  ----  -----  --------  ------------------------
5dfic23e53my123401b8d0e5     15  Yes    30GB    6.07GB  Company ABC Marketing Site
5mdkso12376f987ckif01f10     15  Yes     2GB     1.3GB  Company ABC Documentation Site
5j0amdc4a123456789a6di0c     15  Yes     2GB        0B  Example webapp project
5k987f54omu1234567kmsi56     15  Yes     2GB        0B  Static site project
```

#### Repository ID in the CLI

- [List all repositories](#list-all-repositories)
- [List the repositories in a project](#list-the-repositories-in-a-project)

##### List all repositories

To list all repository IDs in Tugboat:

```sh
tugboat ls repos
```

You'll see a response similar to this:

```sh
   Project: 5dfic23e53my123401b8d0e5 - Company ABC Marketing Site

      Repository ID             Size      Previews  Provider   Name
      ------------------------  --------  --------  ---------  -----------------------
      5dfic23e53my123401b8d0e7  622.72MB         1  github     CompanyABC/marketing
      5dfic6be53my123401b8df5d    5.22GB         2  github     CompanyABC/marketing-assets
      5dfic84e53my123401b8d39a  554.15MB         1  github     CompanyABC/drupal
      5dfic85e53my123401b8d3d9        0B         0  github     CompanyABC/static-site

   Project: 5mdkso12376f987ckif01f10 - Company ABC Documentation Site

      Repository ID             Size      Previews  Provider   Name
      ------------------------  --------  --------  ---------  -----------------------
      5mdkso12376f987ckif0c3dd   435.9MB         2  github     CompanyABC/documentation-site
      5mdkso12376f987ckiffb5fb        0B         0  gitlab     CompanyABC/documentation-assets
      5mdkso12376f987ckifc5fb8        0B         0  bitbucket  CompanyABC/docs-update
      5mdkso12376f987ckif76959  893.33MB         0  github     CompanyABC/docs
```

##### List the repositories in a project

To list only the repository IDs for a specific project with the ID of `5dfic23e53my123401b8d0e5`:

```sh
tugboat ls repos project=5dfic23e53my123401b8d0e5
```

You'll see a response similar to this:

```sh
   Project: 5dfic23e53my123401b8d0e5 - Company ABC Marketing Site

      Repository ID             Size      Previews  Provider   Name
      ------------------------  --------  --------  ---------  -----------------------
      5dfic23e53my123401b8d0e7  622.72MB         1  github     CompanyABC/marketing
      5dfic6be53my123401b8df5d    5.22GB         2  github     CompanyABC/marketing-assets
      5dfic84e53my123401b8d39a  554.15MB         1  github     CompanyABC/drupal
      5dfic85e53my123401b8d3d9        0B         0  github     CompanyABC/static-site
```

#### Preview ID in the CLI

- [List all Previews](#list-all-previews)
- [List the Previews in a specific project](#list-the-previews-in-a-specific-project)
- [List the Previews in a specific repository](#list-the-previews-in-a-specific-repository)

##### List all Previews

To list all Previews:

```sh
tugboat ls previews
```

You'll see a response similar to this:

```sh
   Project: 5dfic23e53my123401b8d0e5 - Company ABC Marketing Site
      Repository: 5dfic23e53my123401b8d0e7 - CompanyABC/marketing

         Preview ID                 OPTS     Status       Size      Name
         ------------------------  --------  -----------  --------  ---------------------
         5dfic54972db400001b8d290    ⚓️ ☾️     ready        622.72MB  master
           https://master-5vt12vtfuqy0chpzdhernpafabmixrny.tugboat.qa

   Project: 5mdkso12376f987ckif01f10 - Company ABC Documentation Site
      Repository: 5mdkso12376f987ckif0c3dd - CompanyABC/documentation-site

          Preview ID                 OPTS     Status       Size      Name
          ------------------------  --------  -----------  --------  ---------------------
          5d3750bee9b02644d56b0a89    ⚓️ ☾️     ready         435.9MB  master
            https://master-kkmsgw224wtjtlbqviabxqitakcfvrdv.tugboat.qa
```

##### List the Previews in a specific project

To list only the Previews in a specific project with the ID of `5dfic23e53my123401b8d0e5`:

```sh
tugboat ls previews project=5dfic23e53my123401b8d0e5
```

You'll see a response similar to this:

```sh
   Project: 5dfic23e53my123401b8d0e5 - Company ABC Marketing Site
      Repository: 5dfic23e53my123401b8d0e7 - CompanyABC/marketing

         Preview ID                 OPTS     Status       Size      Name
         ------------------------  --------  -----------  --------  ---------------------
         5dfic54972db400001b8d290    ⚓️ ☾️     ready        622.72MB  master
           https://master-5vt12vtfuqy0chpzdhernpafabmixrny.tugboat.qa

      Repository: 5dfic6be53my123401b8df5d - CompanyABC/marketing-assets

         Preview ID                 OPTS     Status       Size      Name
         ------------------------  --------  -----------  --------  ---------------------
         5dfic0761394630860890c88    ⚓️ ☾️     ready        554.15MB  master
           https://master-eza4ulhhdmye7lixxpqjvhn6toduj4qg.tugboat.qa
```

##### List the Previews in a specific repository

To list only the Previews in a specific repository with the ID of `5dfic23e53my123401b8d0e7`:

```sh
tugboat ls previews repo=5dfic23e53my123401b8d0e7
```

You'll see a response similar to this:

```sh
   Project: 5mdkso12376f987ckif01f10 - Company ABC Documentation Site
      Repository: 5mdkso12376f987ckif0c3dd - CompanyABC/documentation-site

         Preview ID                 OPTS     Status       Size      Name
         ------------------------  --------  -----------  --------  ---------------------
         5d3750bee9b02644d56b0a89    ⚓️ ☾️     ready         435.9MB  master
           https://master-kmyugw294wtjtlbqviabxqinwecfvrdv.tugboat.qa

         5d8a44a86ada2349d59d309e      ☾️     failed             0B  readme change
           undefined
```

#### Service ID in the CLI

To list the services in a specific Preview with the ID of `5dfic54972db400001b8d290`:

```sh
tugboat ls services preview=5dfic54972db400001b8d290
```

You'll see a response similar to this:

```sh
   Project: 5dfic23e53my123401b8d0e5 - Company ABC Marketing Site
      Repository: 5dfic23e53my123401b8d0e7 - CompanyABC/marketing
         Preview: 5dfic54972db400001b8d290 - master

            Service ID                State        Size      Name
            ------------------------  -----------  --------  -------------------------------
            5e3b45fa9366b18e6412206a  suspended    413.94MB  companyabc-redis
              https://master-mj9lot9hdvlbf1ztqw2zsmdhbasge0i5.tugboat.qa

            5e3b45fa9366b18b8612206c  suspended    1.58GB    companyabc-mongo
              https://master-siza3cf9u5pc5u9qnba3ukd0s63djski.tugboat.qa

            5e3b45fa9366b1583412206e  suspended    1.81GB    companyabc-ui
              https://preview.tugboat.qa/master-9a7qh5wgc5w2n738andbu9hlobe8xmdk

            5e3b45fa9366b1579f122070  suspended    501.52MB  companyabc-api
              https://master-amduoolpi4kaldvbrvamdkobnvwcbn8m.tugboat.qa
```
