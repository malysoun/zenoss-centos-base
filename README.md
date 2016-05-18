# zenoss-centos-base

CentOS 7 base images for Zenoss-related applications.
=======

Base docker centos image for Zenoss. Image is based on the `zenoss/centos-base` image with the JVM installed.

# Releasing
Use git flow to release a version to the `master` branch. A jenkins job can be triggered manually to build and publish the
images to docker hub.  During the git flow release process, update the version in the makefile by removing the `dev`
suffix and then increment the version number in the `develop` branch.

## Versioning  

The version convention is for the `develop` branch to have the next release version, a number higher than what is
 currently released, with the `-dev` suffix. The `master` branch will have the currently released version.  For 
 example, if the currently released version is `1.0.2` the version in the `develop` will be `1.0.3-dev`. 

## Release Steps

1. Check out the `master` branch and make sure to have latest `master`.
  * `git checkout master` 
  * `git pull origin master`

2. Check out the `develop` branch.
  * `git checkout develop`
  * `git pull origin develop`

3. Start release of next version. The version is usually the version in the makefile minus the `-dev` suffix.  e.g., if the version 
  in `develop` is `1.0.3-dev` and in `master` `1.0.2`, then the 
  `<release_name>` will be the new version in `master`, i.e. `1.0.3`.
  *  `git flow release start <release_name>`

4. Update the `VERSION` variable in the make file. e.g set it to `1.0.3`

5. run `make` to make sure everything builds properly.

6. Commit and tag everything, don't push.
  * `git commit....`
  * `git flow release finish <release_name>`
  * `git push origin --tags`

7. You will be on the `develop` branch again. While on `develop` branch, edit the the `VERSION` variable in the makefile to 
be the next development version. For example, if you just released version 1.0.3, then change the `VERSION` variable to 
`1.0.4-dev`.

8. Check in `develop` version bump and push.
  * `git commit...`
  * `git push`

9. Push the `master` branch which should have the new released version.
  * `git checkout master`
  * `git push`
  
10. Have someone manually kick off the jenkins job to build and publish images.
