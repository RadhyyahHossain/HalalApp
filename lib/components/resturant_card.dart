import 'package:flutter/material.dart';
import 'package:halalapp/components/Helpers/resturant.dart';
import 'package:halalapp/constants.dart';
import 'package:halalapp/screens/MainPages/details_page.dart';

class ResturantCard extends StatelessWidget {
  Resturant res;

  ResturantCard({
    super.key,
    required this.res,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => DetailsScreen(
                currentRes: this.res,
              ),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              offset: const Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
        ),
        margin: EdgeInsets.all(10),
        child: AspectRatio(
          aspectRatio: 3 / 1,
          child: Container(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(
                                res.image,
                              ),
                              fit: BoxFit.cover)),
                      // child: Image.network(
                      //   res.image,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                      ),
                      Text(
                        res.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 15),
                      Text(
                        res.address,
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        res.price,
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
