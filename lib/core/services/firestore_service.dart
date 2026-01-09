import 'package:cloud_firestore/cloud_firestore.dart';

/// Service for managing Firestore operations
/// Provides CRUD operations for various collections
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== USERS COLLECTION ====================

  /// Get user data by ID
  Future<Map<String, dynamic>?> getUser(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data();
    } catch (e) {
      throw 'Failed to get user: ${e.toString()}';
    }
  }

  /// Update user data
  Future<void> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Failed to update user: ${e.toString()}';
    }
  }

  /// Get user stream (real-time updates)
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots();
  }

  // ==================== RECIPES COLLECTION ====================

  /// Create a new recipe
  Future<String> createRecipe({
    required String userId,
    required String title,
    required String description,
    String? imageUrl,
    List<String>? ingredients,
    List<String>? instructions,
    int? cookTime,
    String? difficulty,
    String? category,
  }) async {
    try {
      final docRef = await _firestore.collection('recipes').add({
        'userId': userId,
        'title': title,
        'description': description,
        'imageUrl': imageUrl,
        'ingredients': ingredients ?? [],
        'instructions': instructions ?? [],
        'cookTime': cookTime,
        'difficulty': difficulty,
        'category': category,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'likes': 0,
        'views': 0,
      });
      return docRef.id;
    } catch (e) {
      throw 'Failed to create recipe: ${e.toString()}';
    }
  }

  /// Get all recipes
  Future<List<Map<String, dynamic>>> getRecipes({
    int limit = 20,
    String? category,
  }) async {
    try {
      Query query = _firestore.collection('recipes').orderBy('createdAt', descending: true);

      if (category != null) {
        query = query.where('category', isEqualTo: category);
      }

      final snapshot = await query.limit(limit).get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw 'Failed to get recipes: ${e.toString()}';
    }
  }

  /// Get recipes by user
  Future<List<Map<String, dynamic>>> getUserRecipes(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('recipes')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw 'Failed to get user recipes: ${e.toString()}';
    }
  }

  /// Get recipe by ID
  Future<Map<String, dynamic>?> getRecipe(String recipeId) async {
    try {
      final doc = await _firestore.collection('recipes').doc(recipeId).get();
      if (doc.exists) {
        final data = doc.data()!;
        data['id'] = doc.id;
        return data;
      }
      return null;
    } catch (e) {
      throw 'Failed to get recipe: ${e.toString()}';
    }
  }

  /// Update recipe
  Future<void> updateRecipe(String recipeId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('recipes').doc(recipeId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Failed to update recipe: ${e.toString()}';
    }
  }

  /// Delete recipe
  Future<void> deleteRecipe(String recipeId) async {
    try {
      await _firestore.collection('recipes').doc(recipeId).delete();
    } catch (e) {
      throw 'Failed to delete recipe: ${e.toString()}';
    }
  }

  /// Search recipes by title
  Future<List<Map<String, dynamic>>> searchRecipes(String query) async {
    try {
      // Note: This is a simple search. For production, use Algolia or similar
      final snapshot = await _firestore
          .collection('recipes')
          .orderBy('title')
          .startAt([query])
          .endAt(['$query\uf8ff'])
          .limit(20)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw 'Failed to search recipes: ${e.toString()}';
    }
  }

  /// Get recipes stream (real-time updates)
  Stream<QuerySnapshot<Map<String, dynamic>>> getRecipesStream({
    int limit = 20,
    String? category,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection('recipes').orderBy('createdAt', descending: true);

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }

    return query.limit(limit).snapshots();
  }

  // ==================== FAVORITES COLLECTION ====================

  /// Add recipe to favorites
  Future<void> addToFavorites(String userId, String recipeId) async {
    try {
      await _firestore.collection('users').doc(userId).collection('favorites').doc(recipeId).set({
        'recipeId': recipeId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw 'Failed to add to favorites: ${e.toString()}';
    }
  }

  /// Remove recipe from favorites
  Future<void> removeFromFavorites(String userId, String recipeId) async {
    try {
      await _firestore.collection('users').doc(userId).collection('favorites').doc(recipeId).delete();
    } catch (e) {
      throw 'Failed to remove from favorites: ${e.toString()}';
    }
  }

  /// Check if recipe is favorited
  Future<bool> isFavorite(String userId, String recipeId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).collection('favorites').doc(recipeId).get();
      return doc.exists;
    } catch (e) {
      return false;
    }
  }

  /// Get user's favorite recipes
  Future<List<Map<String, dynamic>>> getFavoriteRecipes(String userId) async {
    try {
      final favoritesSnapshot = await _firestore.collection('users').doc(userId).collection('favorites').get();

      final recipeIds = favoritesSnapshot.docs.map((doc) => doc.id).toList();

      if (recipeIds.isEmpty) return [];

      final recipesSnapshot = await _firestore.collection('recipes').where(FieldPath.documentId, whereIn: recipeIds).get();

      return recipesSnapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      throw 'Failed to get favorite recipes: ${e.toString()}';
    }
  }

  // ==================== LIKES/VIEWS ====================

  /// Increment recipe likes
  Future<void> likeRecipe(String recipeId) async {
    try {
      await _firestore.collection('recipes').doc(recipeId).update({
        'likes': FieldValue.increment(1),
      });
    } catch (e) {
      throw 'Failed to like recipe: ${e.toString()}';
    }
  }

  /// Increment recipe views
  Future<void> incrementViews(String recipeId) async {
    try {
      await _firestore.collection('recipes').doc(recipeId).update({
        'views': FieldValue.increment(1),
      });
    } catch (e) {
      throw 'Failed to increment views: ${e.toString()}';
    }
  }

  // ==================== BATCH OPERATIONS ====================

  /// Batch write multiple operations
  Future<void> batchWrite(List<Map<String, dynamic>> operations) async {
    try {
      final batch = _firestore.batch();

      for (final operation in operations) {
        final type = operation['type'] as String;
        final collection = operation['collection'] as String;
        final docId = operation['docId'] as String?;
        final data = operation['data'] as Map<String, dynamic>?;

        final docRef = docId != null
            ? _firestore.collection(collection).doc(docId)
            : _firestore.collection(collection).doc();

        switch (type) {
          case 'set':
            batch.set(docRef, data!);
            break;
          case 'update':
            batch.update(docRef, data!);
            break;
          case 'delete':
            batch.delete(docRef);
            break;
        }
      }

      await batch.commit();
    } catch (e) {
      throw 'Failed to execute batch write: ${e.toString()}';
    }
  }

  // ==================== PAGINATION ====================

  /// Get paginated recipes
  Future<Map<String, dynamic>> getPaginatedRecipes({
    int limit = 20,
    DocumentSnapshot? lastDocument,
    String? category,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection('recipes').orderBy('createdAt', descending: true);

      if (category != null) {
        query = query.where('category', isEqualTo: category);
      }

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      final snapshot = await query.limit(limit).get();

      final recipes = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();

      return {
        'recipes': recipes,
        'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
        'hasMore': snapshot.docs.length == limit,
      };
    } catch (e) {
      throw 'Failed to get paginated recipes: ${e.toString()}';
    }
  }
}
