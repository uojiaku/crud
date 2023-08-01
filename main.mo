import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";

actor {
  type Post = {
    userPrincipal : Principal;
    title : Text;
    description : Text;
  };

  var posts = HashMap.HashMap<Nat, Post>(1, Nat.equal, Hash.hash);

  stable var postIdCount : Nat = 0;

  public func createPost (post: Post) : async () {

    // 1. auth


    // 2. prepare data
      let id : Nat = postIdCount;
      postIdCount+=1;

    // 3. create post
      posts.put(id, post);

    // 4. return confirmation
      ();

  };

  public query func readPost (id : Nat) : async ?Post {

    // 1. auth

    // 2. query data
      let postres : ?Post = posts.get(id);

    // 3. return requested post or null.
      postres;
  };

  public func updatePost (post : Post, id : Nat) : async Text {
    // 1. auth

    // 2. query data
      let postres : ?Post = posts.get(id);

    // 3. validate if exists

      switch (postres) {
        case (null) {
          "You're trying to update a non-existent post.";

        };
        case (?currentPost) {
    // 4. update new post data
        let updatedPost : Post = {
          userPrincipal = currentPost.userPrincipal;
          title = post.title;
          description = post.description;
        };

    // 5. update post
        posts.put(id, updatedPost);

    // 6. return success
        "updated successfully";
        };
      };
  }; 

  public func removePost (id : Nat) : async Text {

    // 1. auth

    // 2. query data
    let postRes : ?Post = posts.get(id); 
    
    // 3. validate if exists
    switch (postRes) {
      case (null) {
        // 3.1 return "error".
        "You're trying to remove a non-existent post.";
      };
      case (_) {
    
    // 5. remove post
        ignore posts.remove(id); // ignores that this function returns a value

    // 6. return success.
      "Post has been successfully removed!"
      }
    }
  }
  
};
