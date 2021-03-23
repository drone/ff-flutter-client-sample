import 'dart:core';


enum FeatureType {
  Delivery,
  Verification,
  Integration,
  Features,
  Efficiency
}

abstract class FeatureCard{

  void setDarkMode(bool value);
  void setEnabled(bool value);
  void setRibbon(bool value);
  void setAvailable(bool value);
  String getFeatureNameImage();

  String featureImageName;
  FeatureType featureType;
  String featureDescription;
  int featureTrialPeriod;
  bool enabled;
  bool available;
  bool hasRibbon;
  bool enabledDarkMode;
}

class CDModule extends FeatureCard {

  CDModule() {
    this.featureImageName   = 'assets/images/cd.png';
    this.featureType        = FeatureType.Delivery;
    this.featureDescription = '';
    this.featureTrialPeriod = -1;
    this.enabled            = false;
    this.available          = true;
    this.hasRibbon          = false;
    this.enabledDarkMode    = false;
  }
  @override
  void setDarkMode(bool value) {
   this.featureImageName = value ? 'assets/images/cd_dark.png' : 'assets/images/cd.png';
  }
  @override
  String getFeatureNameImage() {
    return 'Delivery';
  }

  @override
  void setEnabled(bool value) {
    this.enabled = value;
  }

  @override
  void setRibbon(bool value) {
    this.hasRibbon = value;
  }

  @override
  void setAvailable(bool value) {
    this.available = value;
  }
}

class CVModule extends FeatureCard {

  CVModule() {
    this.featureImageName      = "assets/images/cv.png";
    this.featureType           = FeatureType.Verification;
    this.featureDescription    = "Deploy in peace, verify activities that take place in the system. Identify risk early.";
    this.featureTrialPeriod    = 0;
    this.enabled               = false;
    this.available             = false;
    this.hasRibbon             = false;
    this.enabledDarkMode       = false;
  }
  @override
  void setDarkMode(bool value) {
    this.featureImageName = value ? 'assets/images/cv_dark.png' : 'assets/images/cv.png';
  }

  @override
  String getFeatureNameImage() {
    return 'Verification';
  }

  @override
  void setEnabled(bool value) {
    this.enabled = value;
  }

  @override
  void setRibbon(bool value) {
    this.hasRibbon = value;
  }

  @override
  void setAvailable(bool value) {
    this.available = value;
  }
}

class CIModule extends FeatureCard {

  CIModule() {
    this.featureImageName   = "assets/images/ci.png";
    this.featureType        = FeatureType.Integration;
    this.featureDescription = "Commit, build, and test your code at a whole new level.";
    this.featureTrialPeriod = 0;
    this.enabled            = false;
    this.available          = false;
    this.hasRibbon          = false;
    this.enabledDarkMode    = false;
  }

  @override
  void setDarkMode(bool value) {
    this.featureImageName = value ? 'assets/images/ci_dark.png' : 'assets/images/ci.png';
  }

  @override
  String getFeatureNameImage() {
    return 'Integration';
  }
  @override
  void setEnabled(bool value) {
    this.enabled = value;
  }

  @override
  void setRibbon(bool value) {
    this.hasRibbon = value;
  }

  @override
  void setAvailable(bool value) {
    this.available = value;
  }
}

class CEModule extends FeatureCard {

  CEModule() {
    this.featureImageName   = "assets/images/ce.png";
    this.featureType        = FeatureType.Efficiency;
    this.featureDescription = "Efficiency Spot and quickly debug inefficiencies and optimize them to reduce costs.";
    this.featureTrialPeriod = 0;
    this.enabled            = false;
    this.available          = false;
    this.hasRibbon          = false;
    this.enabledDarkMode    = false;
  }

  @override
  void setDarkMode(bool value) {
    this.featureImageName = value ? 'assets/images/ce_dark.png' : 'assets/images/ce.png';
  }

  @override
  String getFeatureNameImage() {
    return 'Efficiency';
  }
  @override
  void setEnabled(bool value) {
    this.enabled = value;
  }

  @override
  void setRibbon(bool value) {
    this.hasRibbon = value;
  }
  @override
  void setAvailable(bool value) {
    this.available = value;
  }
}

class CFModule extends FeatureCard {
  CFModule() {
    this.featureImageName   = "assets/images/cf.png";
    this.featureType        = FeatureType.Features;
    this.featureDescription = "Decouple release from deployment and rollout features safely and quickly.";
    this.featureTrialPeriod = 0;
    this.enabled            = false;
    this.available          = false;
    this.hasRibbon          = false;
    this.enabledDarkMode    = false;
  }

  @override
  void setDarkMode(bool value) {
    this.featureImageName = value ? 'assets/images/cf_dark.png' : 'assets/images/cf.png';
  }

  @override
  String getFeatureNameImage() {
    return 'Features';
  }

  @override
  void setEnabled(bool value) {
    this.enabled = value;
  }

  @override
  void setRibbon(bool value) {
    this.hasRibbon = value;
  }
  @override
  void setAvailable(bool value) {
    this.available = value;
  }

}
