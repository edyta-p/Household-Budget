// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import DisableButtonController from "./disable_button_controller"
application.register("disable-button", DisableButtonController)

import FadingInController from "./fading_in_controller"
application.register("fading-in", FadingInController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import SearchCardsController from "./search_cards_controller"
application.register("search-cards", SearchCardsController)

import TooltipController from "./tooltip_controller"
application.register("tooltip", TooltipController)
