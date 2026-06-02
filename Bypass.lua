-- [[ ARCHITECT SHIELD PRO - HUSSEIN SYSTEM ]]
-- حقوق الملكية: المطور حسين 🛡️

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- 1. إنشاء واجهة طلب المفتاح أولاً
local ScreenGui = Instance.new("ScreenGui")
pcall(function() ScreenGui.Parent = CoreGui or LocalPlayer:WaitForChild("PlayerGui") end)
ScreenGui.Name = "Hussein_Key_System"

-- لوحة طلب المفتاح
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 350, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -175, 0.4, -100)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyFrame.BorderSizePixel = 2
KeyFrame.Active = true
KeyFrame.Draggable = true

-- عنوان اللوحة
local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.Text = "من تطوير حسين 🛡️"
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.SourceSansBold

-- نص إرشاد المستخدم
local InfoLabel = Instance.new("TextLabel", KeyFrame)
InfoLabel.Size = UDim2.new(1, 0, 0, 30)
InfoLabel.Position = UDim2.new(0, 0, 0, 50)
InfoLabel.Text = "اكتب المفتاح لتفعيل السكربت:"
InfoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextSize = 14
InfoLabel.Font = Enum.Font.SourceSans

-- مربع كتابة المفتاح (TextBox)
local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0, 250, 0, 35)
KeyInput.Position = UDim2.new(0.5, -125, 0, 90)
KeyInput.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Text = ""
KeyInput.PlaceholderText = "اكتب المفتاح هنا..."
KeyInput.TextSize = 14
KeyInput.Font = Enum.Font.Code

-- زر التحقق والتفعيل
local SubmitBtn = Instance.new("TextButton", KeyFrame)
SubmitBtn.Size = UDim2.new(0, 120, 0, 35)
SubmitBtn.Position = UDim2.new(0.5, -60, 0, 145)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
SubmitBtn.Text = "تفعيل الحماية"
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.SourceSansBold

--- 2. دالة تشغيل لوحة الحماية الأساسية (تفتح فقط إذا كان المفتاح صحيحاً)
local function LaunchMainShield()
    KeyFrame:Destroy() -- إغلاق وحذف لوحة المفتاح

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

    -- دالة رصد السكربتات التي تسرق معلوماتك
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

    -- نظام اعتراض وقنص السكربتات الخبيثة
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
end

--- 3. برمجة زر التحقق عند الضغط عليه
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "HUS" then
        LaunchMainShield() -- شغل السكربت لو المفتاح صح
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "خطأ! المفتاح غير صحيح."
        InfoLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
    end
end)
