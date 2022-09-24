source("Lib.R")

    # YN = function(a) {
    #   if (a[1, 1] >= a[1,4] & a[1, 1] <= a[1, 5])
    #   {return ("YES")}
    #   else return("NO")
    # }
res = st_read('Arch/Moscow_PointRel3.shx')
res$geometry <- st_zm(res[[3]])

par(mar = c(1,1,1,1))
  nb_knn = knearneigh(res[,3], k = 12) %>% knn2nb()
  
At = data.frame(matrix(unlist(nb_knn),nrow =length(nb_knn),byrow = TRUE ))
At$X6 = c(1:length(nb_knn))

datawat = data.frame(res$waterlevel[At$X6],res$waterlevel[At$X5],res$waterlevel[At$X4],res$waterlevel[At$X3],res$waterlevel[At$X2],res$waterlevel[At$X1])
finish = data.frame("WLevel(m)" = datawat[,c(1)], "Median" = apply(datawat, 1, median), "StDiv" = apply(datawat, 1, sd))

finish$MaxDiv <- finish[, 2]+1.5*finish[,3]
finish$MinDiv <- finish[, 2]-1.5*finish[,3]
 #finish$Belong = apply(datawat, 1,  )
 #ab = YN(datawat)
