FontLib =  {}
Font = {}     
Font["现"]="0000803FBF208820882488248824BE248824882A080A08093809874842482070"
Font["在"]="400040002000FF7F1000100208020C02EA3F09020802080208020802F87F0800"
Font["时"]="001000103E102210A27F221022103E1022112212221222103E10221000140008"
Font["间"]="0400C83F08200220E223222222222222E223222222222222E223022002280210"
Font["1"]="000000101C10101010101010107C0000"
Font["2"]="0000003C4242424020100804427E0000"
Font["3"]="0000003C4242402018204042423C0000"
Font["4"]="00000020303028242422FE2020F80000"
Font["5"]="0000007E0202021E22404042221C0000"
Font["6"]="000000182402023A4642424244380000"
Font["7"]="0000007E422020101008080808080000"
Font["8"]="0000003C4242422418244242423C0000"
Font["9"]="0000001C22424242625C404024180000"
Font["0"]="00000018244242424242424224180000"
Font[":"]="00000000000018180000000018180000"
Font["/"]="00004020202010100808080404020200"
Font["\\"]="00000204040408080810102020204040"
function FontLib.fromhex(str)
--if str==nil then return end
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end
function FontLib.arraycall(str)
--if str==nil then return end
--print("STR:"..str..Font [str])
return(FontLib.fromhex(Font [str]))

end
function FontLib.invertarraycall(str)

return(FontLib.inverthex(Font [str]))

end
local function BitXOR(a,b)--Bitwise xor
    local p,c=1,0
    while a>0 and b>0 do
        local ra,rb=a%2,b%2
        if ra~=rb then c=c+p end
        a,b,p=(a-ra)/2,(b-rb)/2,p*2
    end
    if a<b then a=b end
    while a>0 do
        local ra=a%2
        if ra>0 then c=c+p end
        a,p=(a-ra)/2,p*2
    end
tmr.wdclr()
    return c
end
function FontLib.inverthex(str)
    return (str:gsub('..', function (cc)
        return string.char(BitXOR(tonumber(cc, 16),255))
    end))
end
return FontLib