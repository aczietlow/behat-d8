# Palantir Base Box Maker

Look on ye mighty and despair: Here is where Palantiri make new base boxes for projects, add new playlists, and update defaults.

##Requirements

* [virtualBox](https://www.virtualbox.org/wiki/Downloads) >= 4.3.x
* OR [vmware fusion](https://www.vmware.com/products/fusion) >= 7.1.1
* [vagrant](http://downloads.vagrantup.com/) >= 1.6.x

## General Overview

The Palantir Maker Box can be the base image for any future internal Vagrant machines. We currently use a basic Ubuntu Server 14.04.2 (64-bit) 
image from [Boxcutter/ubuntu](https://github.com/boxcutter/ubuntu).

The final box is exported to [palantir/ubuntu-default](https://atlas.hashicorp.com/palantir/boxes/ubuntu-default)

### Hierarchy

![config_hierarchy](https://cloud.githubusercontent.com/assets/1851632/6638657/3daf8dd4-c956-11e4-9202-b0c46f96a831.jpg)

## Quick Start: How to build Palantir Maker Box

It is very important to make sure you have checked out a tag before you build a box. The file ```VERSION``` will get bumped AFTER a tag gets cut.

1. From the maker box project root, run ```$ make vmware``` or ```$ make virtualbox```
2. This will produce a build artifact in ```build/{{ MAKER_BOX_NAME }}-{{ provider }}-{{ MAKER_BOX_VERSION }}.box```
3. Upload the box to Palantir's ```palantir-vagrant``` s3 bucket. Each project should have it's own folder, please do not litter the bucket root.
4. Create a version in [Atlas](https://atlas.hashicorp.com) and use the HTTPS address of the s3 artifact. Note: Using a client like Cyberduck allows you to upload to s3 and also get the url of the artifact.
5. In your project, you can now reference your provisioned base box in `Vagrantfile` by referring to its Atlas alias (e.g. `palantir/ubuntu-default`).

## Customizing

* You can rename the base by changing the `project` variable inside the `Vagrantfile` (defaults to `palantir`). All virtual machines are appended with `-box`.
* If you want to add a new playlist, a "testing_playlist.yml", for example, this should be added inside the `provisioning` directory, rather than altering the current playlist.
* The playlist now consists of `php_default_playlist.yml`. Alterations to the php default playlist can be made there in a PR.
* If your specific project requires an additional set of packages and config that are not standard, consider creating a playlist rather than adding those packages to the defaults.
* Update https://github.com/palantirnet/palantir-maker-box/wiki/Vagrant-IP-Address with the next available ip address for your project
