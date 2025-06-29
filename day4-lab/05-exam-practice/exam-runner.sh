#!/bin/bash

# Terraform Associate Exam Practice Runner
# This script helps you take the practice exam with timing

set -e

EXAM_DIR="$(dirname "$0")"
ANSWER_SHEET="$EXAM_DIR/answer-sheet.md"
QUESTIONS="$EXAM_DIR/questions.md"
ANSWER_KEY="$EXAM_DIR/answer-key.md"

echo "🎓 Terraform Associate Practice Exam"
echo "=================================="
echo ""
echo "📋 Exam Details:"
echo "• 60 questions total"
echo "• 60 minutes recommended time"
echo "• Passing score: 70% (42/60 questions)"
echo ""

# Check if files exist
if [[ ! -f "$QUESTIONS" ]]; then
    echo "❌ Error: questions.md not found!"
    exit 1
fi

if [[ ! -f "$ANSWER_SHEET" ]]; then
    echo "❌ Error: answer-sheet.md not found!"
    exit 1
fi

if [[ ! -f "$ANSWER_KEY" ]]; then
    echo "❌ Error: answer-key.md not found!"
    exit 1
fi

echo "📚 Files ready:"
echo "• Questions: $QUESTIONS"
echo "• Answer Sheet: $ANSWER_SHEET"
echo "• Answer Key: $ANSWER_KEY"
echo ""

# Ask user what they want to do
echo "What would you like to do?"
echo "1) Start the exam (60-minute timer)"
echo "2) View questions without timer"
echo "3) Check answers against answer key"
echo "4) View study guide"
echo ""
read -p "Enter your choice (1-4): " choice

case $choice in
    1)
        echo ""
        echo "🚀 Starting 60-minute exam timer..."
        echo "📖 Open questions.md to view questions"
        echo "✏️  Record answers in answer-sheet.md"
        echo ""
        echo "Good luck! 🍀"
        echo ""
        
        # Start 60-minute timer
        echo "⏰ Timer started at $(date)"
        sleep 3600  # 60 minutes
        echo ""
        echo "⏰ TIME'S UP! Please stop working and check your answers."
        echo "📊 Use option 3 to check your answers against the answer key."
        ;;
    
    2)
        echo ""
        echo "📖 Opening questions without timer..."
        echo "📋 Questions are in: $QUESTIONS"
        echo "✏️  Record answers in: $ANSWER_SHEET"
        echo ""
        ;;
    
    3)
        echo ""
        echo "📊 Checking answers..."
        echo "🔍 Compare your answers in answer-sheet.md with answer-key.md"
        echo "📈 Calculate your score and identify areas for improvement"
        echo ""
        echo "Answer key location: $ANSWER_KEY"
        ;;
    
    4)
        echo ""
        echo "📚 Opening study guide..."
        echo "📖 Study guide location: $EXAM_DIR/study-guide.md"
        ;;
    
    *)
        echo "❌ Invalid choice. Please run the script again and choose 1-4."
        exit 1
        ;;
esac

echo ""
echo "📁 Exam files location: $EXAM_DIR"
echo "✅ Happy studying!"