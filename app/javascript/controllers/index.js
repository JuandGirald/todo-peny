// Import and register all your controllers from the importmap under controllers/*
import { application } from "./application"

import DropdownController from "./dropdown_controller.js"
import FlashController from "./flash_controller.js"
import ModalController from "./modal_controller.js"

application.register("dropdown", DropdownController)
application.register("flash", FlashController)
application.register("modal", ModalController)
