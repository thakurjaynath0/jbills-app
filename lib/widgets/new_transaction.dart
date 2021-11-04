import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  final _detailController = TextEditingController();

  DateTime _selectedDate;

  void _sumbit() {
    if(_amountController.text.isEmpty){
      return;
    }
    final titleEnter = _titleController.text;
    final amountEnter = double.parse(_amountController.text);
    final detailEnter = _detailController.text;

    if (titleEnter.isEmpty || amountEnter <= 0 || detailEnter.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addTx(titleEnter, amountEnter, detailEnter, _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
         setState(() {
        _selectedDate= pickedDate;
      });
      }
    
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _sumbit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _sumbit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Detail'),
              controller: _detailController,
              onSubmitted: (_) => _sumbit(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                       child: Text(
                      _selectedDate == null ? 'Date not selected' : 'Selected Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Select Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _datePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _sumbit,
            )
          ],
        ),
      ),
    );
  }
}
