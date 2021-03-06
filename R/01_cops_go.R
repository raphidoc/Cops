#' COPS routine launcher
#'
#'  This the function that should be call to run the whole COPS processing.
#'
#' @param interactive is a logical value: if TRUE, the user is prompted to
#' selected a folder containing COPS file to process. The plots are produced in pop-up windows.
#' If FALSE, you have to create an ASCII file named directories.for.cops.dat and put
#' the full path of the folders you want to process (on by line). The plots are put in a PDF file
#' in a sub-folder ./PDF.
#' @param ASCII is a logical value: if TRUE the outputs are written in simple ASCII files in a ddition to
#' the binary files in RData format.
#' @param CLEAN.FILES is a logical value: if TRUE, the user will be prompt
#' to select the good part of the COPS file interactively.
#' IMPORTANT: the input cops file will be OVERWRITE.
#'
#' @author Bernard Gentili and Simon Belanger
#' @export


cops.go <- function(interactive = FALSE, ASCII=FALSE, CLEAN.FILES=FALSE) {
	assign("INTERACTIVE", interactive, env = .GlobalEnv)
	data("eu.hydrolight")
	data("thuillier.completed.by.AM0AM1")
	data("oz.k")
	data("table.Q")
	data("table.f")
	GreggCarder.data()
	shadow.data()
	if(INTERACTIVE) {
		while(!is.na((dirdat <- tk_choose.dir()))) {
			mymessage(paste("PROCESSING DIRECTORY", dirdat), head = "@", tail = "@")
			process.cops(dirdat)
		}
	} else {
		if(!file.exists("directories.for.cops.dat")) {
			cat("CREATE a file named directories.for.cops.dat in current directory (R working directory)\n")
			cat("  and put in it the names of the directories where data files can be found (one by line)\n")
			stop()
		} else {
			dirdats <- scan(file = "directories.for.cops.dat", "", sep = "\n", comment.char = "#")
			L2 <- getwd()
			for(dirdat in dirdats) {
				if(!file.exists(dirdat)) {
					cat(dirdat, "does not exist")
					stop()
				}
				mymessage(paste("PROCESSING DIRECTORY", dirdat), head = "@", tail = "@")

				tryCatch(
				  expr = {
				    # plot.Rrs.Kd.for.station doesn't close Rstudio graph, it's an issue when batch processing
				    graphics.off()
				    process.cops(dirdat, ASCII, CLEAN.FILES)
				    plot.Rrs.Kd.for.station(dirdat)
				    #message("Succes \\o/")
				  },
				  error = function(e){
				    message("error: /o\\")
				    message(e,"\n")
				    cat(paste0("-----",Sys.time(),"\n",dirdat,"\n",e,"-----\n"),
				        file = file.path(L2,paste0("Cops_errors_",Sys.Date(),".txt")),
				        append = T)
				    #invokeRestart("abort")
				  },
				  #warning = function(w){
				    #message("warning: _o_\n\t\x20\x20|\n\t\x20/ \\")
				    #cat(paste0("-----",dirdat,"\n",w,"\n-----"),
				        #file = file.path(L2,paste0("COPS_warnings_",Sys.Date(),".txt")),
				        #append = T)
				    #invokeRestart("muffleWarning")
				  #},
				  finally = next()
				)
			}
			setwd(L2)
		}
	}
}
