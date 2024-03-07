import json
import sys

if len(sys.argv) != 3:
    print("Usage: python evaluate_submission.py <prediction_file> <submission_file>")
    sys.exit(1)

prediction_file = sys.argv[1]
submission_file = sys.argv[2]

pred_file = [json.loads(x) for x in open(prediction_file)]
sub_file = [json.loads(x) for x in open(submission_file)]

# Check if prediction and submission files have same number of lines
if len(pred_file) != len(sub_file):
    print("Prediction and submission files have different number of lines")
    sys.exit(1)

# Check if qids are in order
if not all([pred_file[i]['qid'] == sub_file[i]['qid'] for i in range(len(pred_file))]):
    print("Prediction and submission files have qids in different order")
    sys.exit(1)


row_score, col_score, cell_score = 0, 0, 0

for i in range(len(pred_file)):
    if sorted(pred_file[i]['label_col']) == sorted(sub_file[i]['label_col']):
        col_score += 1
    if sorted(pred_file[i]['label_row']) == sorted(sub_file[i]['label_row']):
        row_score += 1
    if sorted([tuple(x) for x in pred_file[i]['label_cell']]) == sorted([tuple(x) for x in sub_file[i]['label_cell']]):
        cell_score += 1

row_score /= len(pred_file)
col_score /= len(pred_file)
cell_score /= len(pred_file)
aggre_score = (row_score + col_score + cell_score) / 3

print('### Evaluation Results ###')
print('Row score: %.9f' % row_score)
print('Column score: %.9f' % col_score)
print('Cell score: %.9f' % cell_score)
print('Aggregate score: %.9f' % aggre_score)
