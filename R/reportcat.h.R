
# This file is automatically generated, you probably don't want to edit this

reportcatOptions <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "reportcatOptions",
    inherit = jmvcore::Options,
    public = list(
        initialize = function(
            vars = NULL, ...) {

            super$initialize(
                package="ClinicoPathLinuxDescriptives",
                name="reportcat",
                requiresData=TRUE,
                ...)

            private$..vars <- jmvcore::OptionVariables$new(
                "vars",
                vars,
                suggested=list(
                    "ordinal",
                    "nominal"),
                permitted=list(
                    "factor"))

            self$.addOption(private$..vars)
        }),
    active = list(
        vars = function() private$..vars$value),
    private = list(
        ..vars = NA)
)

reportcatResults <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "reportcatResults",
    inherit = jmvcore::Group,
    active = list(
        todo = function() private$.items[["todo"]],
        text = function() private$.items[["text"]]),
    private = list(),
    public=list(
        initialize=function(options) {
            super$initialize(
                options=options,
                name="",
                title="Summary of Categorical Variables",
                refs=list(
                    "report",
                    "ClinicoPathJamoviModule"))
            self$add(jmvcore::Html$new(
                options=options,
                name="todo",
                title="To Do",
                clearWith=list(
                    "vars")))
            self$add(jmvcore::Preformatted$new(
                options=options,
                name="text",
                title=""))}))

reportcatBase <- if (requireNamespace("jmvcore", quietly=TRUE)) R6::R6Class(
    "reportcatBase",
    inherit = jmvcore::Analysis,
    public = list(
        initialize = function(options, data=NULL, datasetId="", analysisId="", revision=0) {
            super$initialize(
                package = "ClinicoPathLinuxDescriptives",
                name = "reportcat",
                version = c(1,0,0),
                options = options,
                results = reportcatResults$new(options=options),
                data = data,
                datasetId = datasetId,
                analysisId = analysisId,
                revision = revision,
                pause = NULL,
                completeWhenFilled = FALSE,
                requiresMissings = FALSE,
                weightsSupport = 'auto')
        }))

#' Summary of Categorical Variables
#'
#' Function for Generating Summaries for Categorical Variables.
#'
#' @examples
#' \dontrun{
#' # example will be added
#'}
#' @param data the data as a data frame
#' @param vars string naming the variables from \code{data} that contains the
#'   values used for the report.
#' @return A results object containing:
#' \tabular{llllll}{
#'   \code{results$todo} \tab \tab \tab \tab \tab a html \cr
#'   \code{results$text} \tab \tab \tab \tab \tab a preformatted \cr
#' }
#'
#' @export
reportcat <- function(
    data,
    vars) {

    if ( ! requireNamespace("jmvcore", quietly=TRUE))
        stop("reportcat requires jmvcore to be installed (restart may be required)")

    if ( ! missing(vars)) vars <- jmvcore::resolveQuo(jmvcore::enquo(vars))
    if (missing(data))
        data <- jmvcore::marshalData(
            parent.frame(),
            `if`( ! missing(vars), vars, NULL))

    for (v in vars) if (v %in% names(data)) data[[v]] <- as.factor(data[[v]])

    options <- reportcatOptions$new(
        vars = vars)

    analysis <- reportcatClass$new(
        options = options,
        data = data)

    analysis$run()

    analysis$results
}

