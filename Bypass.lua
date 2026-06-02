-- [[ ARCHITECT SHIELD PRO - HUSSEIN EDITION WITH KEY SYSTEM ]]
-- حقوق الملكية: المطور حسين 🛡️

-- 1. إعداد المفتاح السري المطلوب لتشغيل السكربت
local SetKey = "HUS"

-- التحقق من المفتاح قبل تشغيل الواجهة أو نظام الأمان
if _G.HusseinShieldKey ~= SetKey then
    -- إذا كان المفتاح خطأ أو فارغ، يطبع تنبيه في الكونسول ويقفل السكربت فوراً
    warn("🚨 [حظر] المفتاح غير صحيح! لا يمكنك تشغيل سكربت المطور حسين 🛡️ بدون المفتاح المعتمد.")
    return
end

-- 2. الكود الأساسي للوحة (يشتغل فقط إذا كان المفتاح صحيحاً)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

local ScreenGui = Instance.new("ScreenGui")
pcall(function() ScreenGui.Parent = CoreGui or LocalPlayer:WaitForChild("PlayerGui") end)
ScreenGui.Name = "Hussein_Protection_Shield"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 460, 0, 320)
MainFrame.Position = UDim2.new(0.5, -230, 0.35, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 2
MainFrame.Active = true
MainFrame.Draggable = true 

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "المطور حسين 🛡️"
Title.TextColor3 = Color3.fromRGB(50, 200, 50)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold

local LogText = Instance.new("TextLabel", MainFrame)
LogText.Size = UDim2.new(1, -20, 1, -65)
LogText.Position = UDim2.new(0, 10, 0, 55)
LogText.TextXAlignment = Enum.TextXAlignment.Left
LogText.TextYAlignment = Enum.TextYAlignment.Top
LogText.TextColor3 = Color3.fromRGB(220, 220, 220)
LogText.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
LogText.TextSize = 14
LogText.Font = Enum.Font.Code
LogText.TextWrapped = true
LogText.Text = "• جار المراقبة وحمايتك بس..."

-- دالة رصد السكربتات التي تسرق
local function OnDataInterception(url, interceptedData)
    Title.Text = "🚨 المطور حسين | تم حظر سرقة!"
    Title.TextColor3 = Color3.fromRGB(255, 50, 50)
    
    local report = string.format(
        "• جار المراقبة وحمايتك بس...\n" ..
        "-----------------------------------------\n" ..
        "🚨 [تنبيه: يوجد سكربت يسرق معلوماتك]\n" ..
        "• اسم الضحية: %s\n" ..
        "• رابط السحب (URL):\n  %s\n" ..
        "• البيانات المسحوبة:\n  %s\n\n" ..
        "🛡️ تم حظر المحاولة بنجاح بواسطة حسين.",
        LocalPlayer.Name, url, interceptedData
    )
    LogText.Text = report
end

-- نظام اعتراض السكربتات الخبيثة في الخلفية
local originalRequest = (syn and syn.request) or (http and http.request) or request or http_request
if originalRequest then
    local oldReq
    oldReq = hookfunction(originalRequest, function(options)
        local targetUrl = options.Url or "Unknown Webhook"
        local bodyData = options.Body or "محاولة سحب كوكيز أو بيانات الحساب"
        OnDataInterception(targetUrl, bodyData)
        return {StatusCode = 200, Body = '{"status":"success"}'}
    end)
end

local hook
hook = hookmetamethod(game, "__index", function(self, key)
    if tostring(self) == "HttpService" and (key == "PostAsync" or key == "GetAsync") then
        return function(obj, url, data)
            OnDataInterception(url, data or "No Data")
            return '{"status":"ok"}'
        end
    end
    return hook(self, key)
end)

print("--- [HUSSEIN SHIELD] LOADED SUCCESSFULLY WITH KEY ---")
