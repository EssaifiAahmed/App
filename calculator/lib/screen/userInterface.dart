import 'package:flutter/material.dart';


class SIForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _formkey = GlobalKey<FormState>();
  var _currencies = ['Rupees', 'Dollars', 'Pounds', 'MAD'];
  final _minimumPadding = 5.0;
  var _currenciesSelectedItems = '';
  @override
  void initState(){
    super.initState();
    _currenciesSelectedItems = _currencies[0];
  }
  TextEditingController principalControlled = TextEditingController();
  TextEditingController roiControlled = TextEditingController();
  TextEditingController termControlled = TextEditingController();
  var _displayResult = " ";
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interset Calculator'),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding
                ),
                child:TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalControlled,
                  validator: (String validate){
                    if(validate.isEmpty){
                        return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Principal',
                      hintText: 'Enter Principal value',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                )),

            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: roiControlled,
                  validator: (String validate){
                    if(validate.isEmpty){
                      return 'Please enter the rate of interset';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Rate of Interest',
                      hintText: 'In percent',
                      labelStyle: textStyle,
                      errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 15.0
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                ))  ,

            Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom:_minimumPadding
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: textStyle,
                          controller: termControlled,
                          validator: (String validate){
                            if(validate.isEmpty){
                              return 'Please enter the term';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Term',
                              hintText: 'Time in years',
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                color: Colors.yellowAccent,
                                fontSize: 15.0
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              )
                          ),
                        )),
                    Container(
                        width: _minimumPadding * 5
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                          items: _currencies.map((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value, style: textStyle),
                            );
                          }).toList(),
                          value: _currenciesSelectedItems,
                          onChanged: (String newValueSelected){
                            onDropDownItemSelected(newValueSelected);
                          },
                        )),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    bottom: _minimumPadding,top: _minimumPadding
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text('Calculate',),
                          onPressed: (){
                            //code of button
                            setState(() {
                              if(_formkey.currentState.validate()) {
                                this._displayResult = _calculateTotalReturns();
                              }
                            });
                          },
                        )
                    ),
                    Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text('Reset'),
                          onPressed: (){
                            //code of button
                            setState(() {
                              _reset();
                            });
                          },
                        )),
                  ],)),
            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text(this._displayResult, style: textStyle),
            )
          ],
        )),
      ),
    );
  }
  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);
    return Container(
        child: image,
        margin: EdgeInsets.all(_minimumPadding * 10)
    );
  }
  void onDropDownItemSelected(String newValueSelected){
    setState(() {
      this._currenciesSelectedItems = newValueSelected;
    });
  }
  String _calculateTotalReturns(){
    double principal = double.parse(principalControlled.text);
    double roi = double.parse(roiControlled.text);
    double term = double.parse(termControlled.text);
    double totalAmountPayable = principal + (principal * roi * term) / 100;
    String result = 'After $term years, your investment will be wroth '
        '$totalAmountPayable $_currenciesSelectedItems';
    return result;
  }
  void _reset(){
    principalControlled.text = '';
    roiControlled.text = '';
    termControlled.text = '';
    _displayResult = '';
    _currenciesSelectedItems = _currencies[0];
  }
}