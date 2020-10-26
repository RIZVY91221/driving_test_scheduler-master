import 'package:flutter/material.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

class AddTestCentur extends StatefulWidget {
  @override
  _AddTestCenturState createState() => _AddTestCenturState();
}

class _AddTestCenturState extends State<AddTestCentur> {

  TextEditingController controller = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<TestCenter>testCenter=<TestCenter>[
    TestCenter("Aberdeen North"),
    TestCenter("Aberdeen South (Cove)"),
    TestCenter("Aberfeldy"),
    TestCenter("Abergavenny"),
    TestCenter("Aberystwyth (Park Avenue)"),
    TestCenter("Airdrie"),
    TestCenter("Alness"),
    TestCenter("Alnwick"),
    TestCenter("Arbroath"),
    TestCenter("Ashfield "),
    TestCenter("Ashford (Kent)"),
    TestCenter("Ashford (London Middlesex)"),
    TestCenter("Atherton (Manchester)"),
    TestCenter("Aylesbury"),
    TestCenter("Ayr "),
    TestCenter("Bala"),
    TestCenter("Ballachulish"),
    TestCenter("Ballater"),
    TestCenter("Banbury"),
    TestCenter("Banff"),
    TestCenter("Bangor "),
    TestCenter("Barking (Tanner Street)"),
    TestCenter("Barnet (London)"),
    TestCenter("Barnsley"),
    TestCenter("Barnstaple"),
    TestCenter("Barra "),
    TestCenter("Barrow In Furness"),
    TestCenter("Barry"),
    TestCenter("Basildon "),
    TestCenter("Basingstoke"),
    TestCenter("Belvedere (London)"),
    TestCenter("Benbecula Island"),
    TestCenter("Berwick-On-Tweed"),
    TestCenter("Beverley LGV"),
    TestCenter("Birmingham (Cocks Moors Woods)"),
    TestCenter("Birmingham (Garretts Green) "),
    TestCenter("Birmingham (Kings Heath)"),
    TestCenter("Birmingham (Kingstanding)"),
    TestCenter("Birmingham (Shirley)"),
    TestCenter("Birmingham (South Yardley)"),
    TestCenter("Birmingham (Sutton Coldfield)"),
    TestCenter("Bishops Stortford"),
    TestCenter("Bishopbriggs"),
    TestCenter("Blackburn with Darwen "),
    TestCenter("Blackpool"),
    TestCenter("Bletchley"),
    TestCenter("Blyth"),
    TestCenter("Bodmin"),
    TestCenter("Bolton (Manchester)"),
    TestCenter("Borehamwood (London)"),
    TestCenter("Boston"),
    TestCenter("Bradford (Heaton) "),
    TestCenter("Bradford (Manningham)"),
    TestCenter("Bradford (Thornbury)"),
    TestCenter("Brecon"),
    TestCenter("Bredbury (Manchester)"),
    TestCenter("Brentwood (London)"),
    TestCenter("Bridgend"),
    TestCenter("Bridlington"),
    TestCenter("Bristol (Avonmouth)"),
    TestCenter("Bristol (Brislington)"),
    TestCenter("Bristol (Kingswood)"),
    TestCenter("Brodick (Isle of Arran)"),
    TestCenter("Bromley (London)"),
    TestCenter("Bromsgrove"),
    TestCenter("Buckie"),
    TestCenter("Burgess Hill "),
    TestCenter("Burton on Trent"),
    TestCenter("Bury (Manchester)"),
    TestCenter("Bury St Edmunds"),
    TestCenter("Buxton"),
    TestCenter("Caernarfon LGV"),
    TestCenter("Callander"),
    TestCenter("Camborne "),
    TestCenter("Cambridge (Brookmount Court)"),
    TestCenter("Cambridge (Hardwick)"),
    TestCenter("Campbeltown"),
    TestCenter("Canterbury"),
    TestCenter("Canterbury LGV"),
    TestCenter("Cardiff (Llanishen)"),
    TestCenter("Cardigan"),
    TestCenter("Cardington "),
    TestCenter("Carlisle "),
    TestCenter("Carlisle LGV"),
    TestCenter("Carmarthen"),
    TestCenter("Castle Douglas"),
    TestCenter("Chadderton"),
    TestCenter("Cheadle (Fire Station)"),
    TestCenter("Cheetham Hill (Manchester)"),
    TestCenter("Chelmsford (Hanbury Road)"),
    TestCenter("Cheltenham"),
    TestCenter("Chertsey (London)"),
    TestCenter("Chester "),
    TestCenter("Chesterfield"),
    TestCenter("Chichester"),
    TestCenter("Chingford (London)"),
    TestCenter("Chippenham"),
    TestCenter("Chorley"),
    TestCenter("Clacton-on- Sea"),
    TestCenter("Colchester"),
    TestCenter("Coventry "),
    TestCenter("Crawley"),
    TestCenter("Crewe"),
    TestCenter("Crieff"),
    TestCenter("Croydon (London)"),
    TestCenter("Culham LGV"),
    TestCenter("Cumnock"),
    TestCenter("Darlington "),
    TestCenter("Darlington LGV"),
    TestCenter("Derby (Alvaston)"),
    TestCenter("Doncaster"),
    TestCenter("Dorchester "),
    TestCenter("Dudley"),
    TestCenter("Dumbarton"),
    TestCenter("Dumfries"),
    TestCenter("Dumfries LGV "),
    TestCenter("Dundee "),
    TestCenter("Dunfermline"),
    TestCenter("Dunoon"),
    TestCenter("Duns"),
    TestCenter("Durham "),
    TestCenter("East Kilbride"),
    TestCenter("Eastbourne"),
    TestCenter("Edinburgh (Currie)"),
    TestCenter("Edinburgh (Musselburgh)"),
    TestCenter("Elgin"),
    TestCenter("Elgin LGV"),
    TestCenter("Elswick"),
    TestCenter("Enfield (Innova Business Park)"),
    TestCenter("Enfield (Brancroft Way)"),
    TestCenter("Erith (London)"),
    TestCenter("Exeter "),
    TestCenter("Exeter LGV"),
    TestCenter("Farnborough "),
    TestCenter("Featherstone "),
    TestCenter("Folkestone"),
    TestCenter("Forfar"),
    TestCenter("Fort William"),
    TestCenter("Fraserburgh"),
    TestCenter("Gairloch"),
    TestCenter("Galashiels "),
    TestCenter("Gateshead "),
    TestCenter("Gillingham "),
    TestCenter("Gillingham LGV"),
    TestCenter("Girvan"),
    TestCenter("Glasgow (Anniesland)"),
    TestCenter("Glasgow (Baillieston)"),
    TestCenter("Glasgow (Shieldhall)"),
    TestCenter("Glasgow LGV"),
    TestCenter("Gloucester "),
    TestCenter("Golspie"),
    TestCenter("Goodmayes (London)"),
    TestCenter("Gosforth "),
    TestCenter("Grangemouth"),
    TestCenter("Grantham (Somerby)"),
    TestCenter("Grantown-On-Spey"),
    TestCenter("Greenford (London)"),
    TestCenter("Greenford (Whitton Ave East)"),
    TestCenter("Greenham"),
    TestCenter("Greenock"),
    TestCenter("Grimsby Coldwater"),
    TestCenter("Guildford "),
    TestCenter("Haddington"),
    TestCenter("Halifax"),
    TestCenter("Hamilton"),
    TestCenter("Harlescott LGV"),
    TestCenter("Hartlepool"),
    TestCenter("Hastings (Ore) "),
    TestCenter("Hawick"),
    TestCenter("Heckmondwike"),
    TestCenter("Hendon (London)"),
    TestCenter("Hereford"),
    TestCenter("Herne Bay "),
    TestCenter("Hexham"),
    TestCenter("Heysham"),
    TestCenter("High Wycombe"),
    TestCenter("Hinckley"),
    TestCenter("Hither Green (London)"),
    TestCenter("Hornchurch (London)"),
    TestCenter("Horsforth"),
    TestCenter("Huddersfield"),
    TestCenter("Hull "),
    TestCenter("Huntly"),
    TestCenter("Hyde (Manchester)"),
    TestCenter("Inveraray"),
    TestCenter("Inverness (Seafield Road)"),
    TestCenter("Inverurie "),
    TestCenter("Ipswich "),
    TestCenter("Irvine "),
    TestCenter("Isle of Mull"),
    TestCenter("Islay Island"),
    TestCenter("Isle of Skye (Broadford)"),
    TestCenter("Isle of Skye (Portree)"),
    TestCenter("Isle of Tiree"),
    TestCenter("Isles of Scilly"),
    TestCenter("Isleworth (Fleming Way)"),
    TestCenter("Kelso"),
    TestCenter("Kendal (Oxenholme Road)"),
    TestCenter("Kettering "),
    TestCenter("Kilmarnock LGV"),
    TestCenter("Kings Lynn "),
    TestCenter("Kingussie"),
    TestCenter("Kirkcaldy "),
    TestCenter("Kirkham LGV"),
    TestCenter("Knaresborough"),
    TestCenter("Kyle of Lochalsh"),
    TestCenter("Lairg"),
    TestCenter("Lanark"),
    TestCenter("Lancing "),
    TestCenter("Launceston"),
    TestCenter("Lee On The Solent "),
    TestCenter("Leeds "),
    TestCenter("Leicester (Wigston) "),
    TestCenter("Leicester (Cannock Street)"),
    TestCenter("Leighton Buzzard (Stanbridge Road)"),
    TestCenter("Lerwick "),
    TestCenter("Letchworth"),
    TestCenter("Lichfield"),
    TestCenter("Lincoln "),
    TestCenter("Liverpool LGV (System)"),
    TestCenter("Livingston"),
    TestCenter("Llandrindod Wells"),
    TestCenter("Llanelli"),
    TestCenter("Llantrisant "),
    TestCenter("Lochgilphead"),
    TestCenter("Loughborough"),
    TestCenter("Loughton (London)"),
    TestCenter("Louth"),
    TestCenter("Lowestoft(Mobbs Way)"),
    TestCenter("Ludlow"),
    TestCenter("Luton"),
    TestCenter("Macclesfield "),
    TestCenter("Macclesfield (RUFC)"),
    TestCenter("Machrihanish LGV"),
    TestCenter("Maidstone"),
    TestCenter("Mallaig"),
    TestCenter("Malton"),
    TestCenter("Melton Mowbray"),
    TestCenter("Merthyr Tydfil "),
    TestCenter("Middlesbrough"),
    TestCenter("Mill Hill (London)"),
    TestCenter("Mitcham (London)"),
    TestCenter("Monmouth"),
    TestCenter("Montrose "),
    TestCenter("Morden (London)"),
    TestCenter("Nelson"),
    TestCenter("Newbury (Hambridge Lane)"),
    TestCenter("Newport (Gwent) "),
    TestCenter("Newport (Gwent) LGV"),
    TestCenter("Newport (Isle Of Wight)"),
    TestCenter("Newton Abbot"),
    TestCenter("Newton Stewart"),
    TestCenter("Newtown"),
    TestCenter("Norris Green (Liverpool)"),
    TestCenter("Northallerton"),
    TestCenter("Northampton"),
    TestCenter("Northwich"),
    TestCenter("Norwich (Peachman Way) "),
    TestCenter("Norwich (Jupiter Road) "),
    TestCenter("Nottingham (Chilwell) "),
    TestCenter("Nottingham (Colwick )"),
    TestCenter("Nuneaton"),
    TestCenter("Oban"),
    TestCenter("Orkney "),
    TestCenter("Oswestry"),
    TestCenter("Oxford (Cowley)"),
    TestCenter("Oxford (Kassam Stadium)"),
    TestCenter("Paisley"),
    TestCenter("Patrick Green LGV"),
    TestCenter("Peebles"),
    TestCenter("Pembroke Dock"),
    TestCenter("Penzance"),
    TestCenter("Perth (Arran Road)"),
    TestCenter("Peterborough"),
    TestCenter("Peterborough LGV"),
    TestCenter("Peterhead"),
    TestCenter("Pinner (London)"),
    TestCenter("Pitlochry"),
    TestCenter("Plymouth "),
    TestCenter("Plymouth LGV"),
    TestCenter("Pontefract"),
    TestCenter("Poole"),
    TestCenter("Portsmouth"),
    TestCenter("Preston"),
    TestCenter("Pwllheli"),
    TestCenter("Reading"),
    TestCenter("Redditch "),
    TestCenter("Redhill Aerodrome"),
    TestCenter("Rhyl"),
    TestCenter("Rochdale (Manchester)"),
    TestCenter("Rookley LGV "),
    TestCenter("Rotherham "),
    TestCenter("Rothesay"),
    TestCenter("Rugby"),
    TestCenter("Sale (Manchester)"),
    TestCenter("Salisbury"),
    TestCenter("Scarborough"),
    TestCenter("Scunthorpe "),
    TestCenter("Sevenoaks"),
    TestCenter("Sheffield (Handsworth)"),
    TestCenter("Sheffield (Middlewood Road)"),
    TestCenter("Shrewsbury "),
    TestCenter("Sidcup (London)"),
    TestCenter("Skegness"),
    TestCenter("Skipton"),
    TestCenter("Slough (London)"),
    TestCenter("South Shields"),
    TestCenter("South Uist"),
    TestCenter("Southall (London)"),
    TestCenter("Southampton (Forest Hills)"),
    TestCenter("Southampton (Maybush)"),
    TestCenter("Southampton LGV"),
    TestCenter("Southend-on-Sea"),
    TestCenter("Southport  (Liverpool)"),
    TestCenter("Speke  (Liverpool)"),
    TestCenter("St Albans"),
    TestCenter("St Helens  (Liverpool)"),
    TestCenter("Stafford"),
    TestCenter("Steeton"),
    TestCenter("Stevenage"),
    TestCenter("Stirling"),
    TestCenter("Stoke on Trent (Cobridge)"),
    TestCenter("Stoke on Trent (Newcastle under Lyme)"),
    TestCenter("Stornoway "),
    TestCenter("Stornoway LGV"),
    TestCenter("Stranraer"),
    TestCenter("Sunderland"),
    TestCenter("Swansea "),
    TestCenter("Swindon "),
    TestCenter("Swindon LGV"),
    TestCenter("Taunton "),
    TestCenter("Telford"),
    TestCenter("Thurrock LGV (London)"),
    TestCenter("Thurso"),
    TestCenter("Tilbury"),
    TestCenter("Tottenham"),
    TestCenter("Tolworth (London)"),
    TestCenter("Trowbridge"),
    TestCenter("Tunbridge Wells"),
    TestCenter("Ullapool"),
    TestCenter("Upton"),
    TestCenter("Uxbridge (London)"),
    TestCenter("Wakefield "),
    TestCenter("Wallasey"),
    TestCenter("Walton LGV"),
    TestCenter("Wanstead (London)"),
    TestCenter("Warrington"),
    TestCenter("Warwick (Wedgenock House)"),
    TestCenter("Watford"),
    TestCenter("Watnall "),
    TestCenter("Wednesbury"),
    TestCenter("Weedon LGV"),
    TestCenter("Wellingborough "),
    TestCenter("West Didsbury (Manchester)"),
    TestCenter("West Wickham (London)"),
    TestCenter("Westbury"),
    TestCenter("Weston-super-Mare"),
    TestCenter("Whitby"),
    TestCenter("Whitchurch"),
    TestCenter("Wick"),
    TestCenter("Widnes (Liverpool)"),
    TestCenter("Winchester"),
    TestCenter("Wolverhampton "),
    TestCenter("Wood Green (London)"),
    TestCenter("Worcester"),
    TestCenter("Workington"),
    TestCenter("Worksop"),
    TestCenter("Wrexham "),
    TestCenter("Wrexham LGV"),
    TestCenter("Yeading (London)"),
    TestCenter("Yeovil"),
    TestCenter("York"),
  ];
  List<TestCenter> _searchListItem=[];

  @override
  void initState() {
    // TODO: implement initState

    //testCenter.sort();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(0xFF094869),
        title:Text("ADD TEST CENTER"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ) ,
      body: Padding(
        padding: EdgeInsets.all(5),
        child:new Column(
          children: <Widget>[
            new Container(
              color: Theme.of(context).primaryColor,
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: 'Search Test Center', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
               child: _searchListItem.length!=0||controller.text.isNotEmpty?
               ListView.separated(
                   itemBuilder: (BuildContext context,int index){
                     return ListTile(

                       onLongPress: (){
                         setState(() {
                           _searchListItem[index].selected = !testCenter[index].selected;
                           print(_searchListItem[index].selected.toString());
                         });
                       },
                       title: Text(_searchListItem[index].name,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                       leading: CircleAvatar(
                         radius: 25,
                         backgroundColor: !_searchListItem[index].selected?Color(0xFF094869):Colors.greenAccent,
                         child: !_searchListItem[index].selected?Text(_searchListItem[index].name.substring(0,1),style: TextStyle(color: Colors.white),):
                         Icon(Icons.done,color: Colors.white,),
                       ),
                     );
                   },
                   separatorBuilder: (context, index) {
                     return Divider();
                   },
                   itemCount:_searchListItem.length ):
               ListView.separated(
                   itemBuilder: (BuildContext context,int index){
                     return ListTile(

                       onLongPress: (){
                         setState(() {
                           testCenter[index].selected = !testCenter[index].selected;
                           print(testCenter[index].selected.toString());
                         });
                       },
                       title: Text(testCenter[index].name,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
                       leading: CircleAvatar(
                         radius: 25,
                         backgroundColor: !testCenter[index].selected?Color(0xFF094869):Colors.greenAccent,
                         child: !testCenter[index].selected?Text(testCenter[index].name.substring(0,1),style: TextStyle(color: Colors.white),):
                         Icon(Icons.done,color: Colors.white,),
                       ),
                     );
                   },
                   separatorBuilder: (context, index) {
                     return Divider();
                   },
                   itemCount:testCenter.length )
            )
          ],
        ),
      ),
    );
  }
  onSearchTextChanged(String text) async {
    _searchListItem.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    testCenter.forEach((TestCenter) {
      if (TestCenter.name.toLowerCase().contains(text))
        _searchListItem.add(TestCenter);
    });

    setState(() {});
  }


}
class TestCenter{
  final String name;
  bool selected = false;

  TestCenter(this.name);
}