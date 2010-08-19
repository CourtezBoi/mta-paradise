function removeBlur ( source )
    setPlayerBlurLevel ( source, 0 )
end


addEventHandler ( "onPlayerVehicleEnter", getRootElement(), removeBlur )