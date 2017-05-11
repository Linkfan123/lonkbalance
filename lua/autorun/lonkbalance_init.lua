LB = {}
LB.version = "...let's just say it's in development"
-- Create a new class that inherits from a base class
-- From http://lua-users.org/wiki/InheritanceTutorial
function LB.inheritsFrom( baseClass )

    -- The following lines are equivalent to the SimpleClass example:

    -- Create the table and metatable representing the class.
    local new_class = {}
    local class_mt = { __index = new_class }

    -- Note that this function uses class_mt as an upvalue, so every instance
    -- of the class will share the same metatable.
    --
    function new_class:make()
        local newinst = {}
        setmetatable( newinst, class_mt )
        return newinst
    end

    -- The following is the key to implementing inheritance:

    -- The __index member of the new class's metatable references the
    -- base class.  This implies that all methods of the base class will
    -- be exposed to the sub-class, and that the sub-class can override
    -- any of these methods.
    --
    if baseClass then
        setmetatable( new_class, { __index = baseClass } )
    end

    return new_class
end
function LB.createDelayedTimer(timerName, initialDelay, repeatTime, timesToRepeat, func)
  timer.Simple(initialDelay, function()
      func()
      timer.Create(timerName, repeatTime, timesToRepeat, func)
    end
    )
end
if CLIENT then
  LB.createDelayedTimer("LBBuletin", 15, 3600, 0, function()
    local red = Color(255, 0, 0, 255)
    local yellow = Color(255, 255, 0, 255)
    local green = Color(0, 255, 0, 0)
    chat.AddText(yellow, "This server is running lonkbalance " .. LB.version .. ".")
    chat.AddText(red, "THE VANILA WEAPONS WILL NOT WORK LIKE YOU'RE USED TO. THEY HAVE BEEN EDITED FOR BETTER BALANCING.")
    chat.AddText(yellow, "LB is in beta. If you think something should be added, message me on GitHub.")
  end)
end
