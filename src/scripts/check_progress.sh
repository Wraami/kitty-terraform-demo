#!/bin/bash

# --- update these to match your code if you're feeling extra creative! ---
ENDPOINT="http://localhost:4566"
REGION="eu-west-1"
BUCKET="treat-store"
TABLE="treat-inventory"
ROLE="treat-dispenser-role"
TOPIC="scratcher-topic"
QUEUE="scratcher-queue"
SUCCESS_COUNT=0 #No hardcoding this to 7 please!
TOTAL=5
BONUS_TOTAL=7

echo "------------------------------------------------"
echo "🐈  TEMPTATIONS HQ: RECOVERY MONITOR  🐈"
echo "------------------------------------------------"

# 1. Check if LocalStack is on
if aws --endpoint-url=$ENDPOINT s3 ls > /dev/null 2>&1; then
    echo -e "✅ [0.1] Foundation: LocalStack is UP and talking!"
    else
    echo -e "❌ [0.1] Foundation: LocalStack is DOWN. Is Docker running?"
fi

# 1.1 Check if the terraform provider is configured properly
if terraform -chdir=../../terraform providers 2>/dev/null | grep -q "hashicorp/aws.*~> 5.0"; then
    echo -e "✅ [1] Foundation: Terraform AWS provider has been configured 😸."
    ((SUCCESS_COUNT++))
else
    echo -e "❌ [1] Foundation: Terraform AWS provider not found. Check your terraform configuration and try again!!"
fi

# 2. S3 Bucket (Checking for Public Access Block)
if aws --endpoint-url=$ENDPOINT s3api get-public-access-block --bucket "$BUCKET" 2>/dev/null | grep -q "true"; then
    echo -e "✅ [2] S3 Security: the config issue is fixed! congrats!."
    ((SUCCESS_COUNT++))
elif aws --endpoint-url=$ENDPOINT s3api head-bucket --bucket "$BUCKET" 2>/dev/null; then
    echo -e "⚠️  [2] S3 Bucket: Found, but security is still iffy (fix the Public Access!)"
else
    echo -e "⭕ [2] S3 Bucket: Not found yet."
fi

# 3. S3 Bucket Policy
if aws --endpoint-url=$ENDPOINT s3api get-bucket-policy --bucket "$BUCKET" 2>/dev/null; then
    echo -e "✅ [3] Policy: Bucket Policy attached."
    ((SUCCESS_COUNT++))
else
    echo -e "⭕ [3] Policy: Bucket Policy missing."
fi

# 4. DynamoDB
if aws --endpoint-url=$ENDPOINT dynamodb describe-table --table-name "$TABLE" 2>/dev/null | grep -q "ACTIVE"; then
    echo -e "✅ [4] Database: DynamoDB table is online and active."
    ((SUCCESS_COUNT++))
else
    echo -e "⭕ [4] Database: DynamoDB missing."
fi

# 5. IAM Role & Policy
if aws --endpoint-url=$ENDPOINT iam get-role --role-name "$ROLE" 2>/dev/null; then
    echo -e "✅ [5] Identity: IAM Role established."
    ((SUCCESS_COUNT++))
else
    echo -e "⭕ [5] Identity: Role missing."
fi

# 6. SNS Topic
if aws --endpoint-url=$ENDPOINT sns list-topics 2>/dev/null | grep -q "$TOPIC"; then
    echo -e "✅ [6] Messaging: SNS topic '$TOPIC' exists."
    ((SUCCESS_COUNT++))
else
    echo -e "⭕ [6] Messaging: SNS topic '$TOPIC' not found."
fi

# 7. SQS Queue + Subscription
if aws --endpoint-url=$ENDPOINT sqs get-queue-url --queue-name "$QUEUE" >/dev/null 2>&1; then
    if aws --endpoint-url=$ENDPOINT sns list-subscriptions 2>/dev/null | grep -q "$QUEUE"; then
        echo -e "✅ [7] Messaging: SQS queue '$QUEUE' and subscription present."
        ((SUCCESS_COUNT++))
    else
        echo -e "⚠️  [7] Messaging: SQS queue exists but subscription from SNS -> SQS seems missing."
    fi
else
    echo -e "⭕ [7] Messaging: SQS queue '$QUEUE' not found."
fi

echo "------------------------------------------------"
echo "Run this script again after your 'terraform apply'!"

echo ""
echo "📊 Summary: $SUCCESS_COUNT / $BONUS_TOTAL checks passed"

if [ "$SUCCESS_COUNT" -ge "$BONUS_TOTAL" ]; then
    echo -e "\033[0;32m"
    echo "**********************************************"
    echo "   🎉 CONGRATS! YOU'VE BEEN PROMOTED! 🎉    "
    echo "     Enjoy all the unlimited company temptations your heart desires     "
    echo "**********************************************"
    echo "----------------------------------------------"
elif [ "$SUCCESS_COUNT" -ge "$TOTAL" ]; then
    echo -e "\033[0;32m"
    echo "**********************************************"
    echo "   🎉 CONGRATS! BIG BOSS IS IMPRESSED! 🎉    "
    echo "      Temptations HQ is officially back in business again!      "
    echo "**********************************************"
    echo "----------------------------------------------"
else
    REMAINING=$((TOTAL - SUCCESS_COUNT))
    if [ "$REMAINING" -lt 0 ]; then
        REMAINING=0
    fi
    echo "💡 Almost there! You have $REMAINING tasks left before the big boss is happy."
fi
