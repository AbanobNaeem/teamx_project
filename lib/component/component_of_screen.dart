import 'package:flutter/material.dart';

Widget suggestionsItem() {
  return InkWell(
    onTap: () {
      print('taped');
    },
    child: Row(
      children: [
        Card(
          shadowColor: Colors.red,
          margin: const EdgeInsets.only( bottom: 5, right: 5, left: 10),
          color: Colors.grey[900],
          elevation: 10,
          child: Container(
            width: 320,
            height: 165,
            child: Row(
              children: [
                Image.network(
                  "https://static.wikia.nocookie.net/bakemonogatari1645/images/c/c2/Owari_cover.jpg/revision/latest/scale-to-width-down/345?cb=20190707082059",
                  height: 150,
                  width: 120,
                  alignment: Alignment.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Name of anime",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      Text(
                        "recommended",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 65,
                      ),
                      Text(
                        "Name of writer",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      Text(
                        "Number of Chapter",
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget animeItem(BuildContext context ,
    { required numberOfChapters,required  name,required image, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.only(
          top: 10, bottom: 10, right: 2, left: 2),
      child: Card(
        shadowColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        elevation: 10,
        child: Container(
          width: 130,
          height: 235,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[900]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                child: Image.network(
                  image,
                  width: 130,
                  height: 160,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    Text(
                      numberOfChapters,
                      style: TextStyle(
                          color: Colors.grey[300], fontSize: 12),
                    ),
                    const SizedBox(height: 10,),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.star_border_outlined,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5,),
                          Text(
                            "3.9",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    ),
  );
}



Widget textFormField({
  required String hintTitle,
  required TextEditingController controller,
  required bool obscureText,
  required TextInputType keyType,
  required TextInputAction inputAction,

}
){
  return Container(
    height: 80,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
    ),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.only(left:20),
        child: TextFormField(
          keyboardType: keyType,
          textInputAction: inputAction,
          obscureText: obscureText,
          controller: controller,
          cursorColor: Colors.red,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintTitle,
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 17
              )
          ),
        ),
      ),
    ),
  );


}
Widget drawerComponent({
  required VoidCallback tap ,
  required String  title ,
  required IconData icons,
}){
  return InkWell(
    onTap: tap,
    child: Row(
      children:  [
        Expanded(
          child: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
        ),
        Icon(icons,
          color: Colors.white,)

      ],
    ),
  );
}


Widget userDataComponent({
  required String name,
  required IconData icon ,
  
}){
  return Padding(
    padding: const EdgeInsets.only(left: 5,right: 5,bottom: 20),
    child: Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.red.shade800, Colors.red.shade600, Colors.red.shade300],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Row(
          children: [
           const  SizedBox(width: 10,),
            Expanded(
              child: Text(name,
                style:const  TextStyle(
                    color: Colors.white,
                    fontSize: 17
                ),),
            ),
            Icon(icon,
              color: Colors.white,)


          ],
        ),
      ),
    ),
  );
}
