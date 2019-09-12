// Support component names relative to this directory:
var componentRequireContext = require.context("components", true);
var ReactRailsUJS = require("react_ujs");
ReactRailsUJS.useContext(componentRequireContext);
const Rails = require('rails-ujs');
import 'scripts/editor'
Rails.start();
