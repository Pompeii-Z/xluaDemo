local Controller= {}

function Controller:Start()
    print("SignIn Start")
end

function Controller:Update()
    print("SignIn Update")
end

function Controller:OnDestroy()
    print("SignIn OnDestroy")
end

return Controller