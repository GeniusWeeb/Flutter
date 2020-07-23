//this is the file that isopened when the user clicks on the specific link
// if the user has not signed  in , they should sign in

// we can keep it somewhat linked to the HomeScreen

//Note: Not accessible unless u click the invite link

//process ;

//1. grab the user id and path to connect to the
//  remote firestore link and get inside the node's joined section

//2. it will listen for concurrent changes made in the reading area

//3. Depepnding on the number of users joined , list build view will work

//4 if a user quits , then we delete them from that node

// the user will terminate the app resulting in destorying of Uid node , that will break all others and exit the view.

//######set expiration timer for dynamic link ############//

//things to hande ? <when a client leaves a room , can he reconnect ? maybe no , timer : maybe yes>

//how do we make him leave a firebase node ?
//->some sort of reference that will make it self destory its ui in the node and disconnect it.



//we could create a stream () that will listen for joined clients state , and re update it. 
