import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Auto-register any controllers in this folder (Importmap-friendly)
eagerLoadControllersFrom("controllers", application)