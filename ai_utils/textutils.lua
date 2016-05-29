local textUtils = {}

-- Split input string into a table specifying seperator. Defaults to space.
function textUtils.Split(_inputstr, _sep)
        if _inputstr == nil then
			local t = {};
			return t;
        end
        
        if _sep == nil then
                _sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(_inputstr, "([^".._sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

--[[
	Returns a string of all characters after the specified token.
--]]
function textUtils.ReturnStringAfter(_string, _afterToken)
	
	local fResult, sResult = _string:match("([^,]+)".._afterToken.."([^,]+)")
	
	return sResult;

end

--[[
	Returns a string of all characters before the specified token.
--]]
function textUtils.ReturnStringBefore(_string, _beforeToken)
	
	local fResult, sResult = _string:match("([^,]+)".._beforeToken.."([^,]+)")
	
	return fResult;

end

return textUtils;
