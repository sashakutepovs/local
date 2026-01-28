def tlog(message)
    time=Time.now.strftime("%Y%m%d  %H:%M:%S-%L")
        p sprintf("%-35s TIME=%21s",message,time)
 end