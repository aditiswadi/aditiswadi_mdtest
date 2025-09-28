import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aditiswadi_mdtest/features/src/data/datasources/user_remote_data_source.dart';

import 'user_remote_data_source_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  FirebaseFirestore,
  UserCredential,
  User,
  DocumentReference,
  DocumentSnapshot,
  CollectionReference,
  QuerySnapshot,
])
void main() {
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late UserRemoteDataSourceImpl dataSource;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    dataSource = UserRemoteDataSourceImpl(
      firebaseAuth: mockAuth,
      firestore: mockFirestore,
    );
  });

  group('signUp', () {
    test('should create user and save to firestore', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      final mockDocRef = MockDocumentReference();
      final mockCollection = MockCollectionReference();

      when(
        mockAuth.createUserWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('123');
      when(
        mockFirestore.collection('users'),
      ).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
      when(mockCollection.doc('123')).thenReturn(mockDocRef);
      when(mockDocRef.set(any)).thenAnswer((_) async => {});

      final result = await dataSource.signUp(
        fullName: 'Test',
        email: 'test@email.com',
        password: 'pass',
      );
      expect(result.id, '123');
      expect(result.fullName, 'Test');
      expect(result.email, 'test@email.com');
      expect(result.isVerified, false);
    });
  });

  group('signIn', () {
    test('should sign in user and return user model', () async {
      final mockUserCredential = MockUserCredential();
      final mockUser = MockUser();
      final mockDocRef = MockDocumentReference();
      final mockDocSnap = MockDocumentSnapshot();
      final mockCollection = MockCollectionReference();

      when(
        mockAuth.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        ),
      ).thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.uid).thenReturn('123');
      when(
        mockFirestore.collection('users'),
      ).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
      when(mockCollection.doc('123')).thenReturn(mockDocRef);
      when(mockDocRef.get()).thenAnswer((_) async => mockDocSnap);
      when(mockDocSnap.exists).thenReturn(true);
      when(mockDocSnap.data()).thenReturn({
        'fullName': 'Test',
        'email': 'test@email.com',
        'isVerified': false,
      });
      when(mockDocSnap.id).thenReturn('123');

      final result = await dataSource.signIn(
        email: 'test@email.com',
        password: 'pass',
      );
      expect(result.id, '123');
      expect(result.fullName, 'Test');
      expect(result.email, 'test@email.com');
      expect(result.isVerified, false);
    });
  });

  group('signOut', () {
    test('should call signOut on firebaseAuth', () async {
      when(mockAuth.signOut()).thenAnswer((_) async => {});
      await dataSource.signOut();
      verify(mockAuth.signOut()).called(1);
    });
  });

  group('resetPassword', () {
    test('should call sendPasswordResetEmail', () async {
      when(
        mockAuth.sendPasswordResetEmail(email: anyNamed('email')),
      ).thenAnswer((_) async => {});
      await dataSource.resetPassword('test@email.com');
      verify(
        mockAuth.sendPasswordResetEmail(email: 'test@email.com'),
      ).called(1);
    });
  });

  group('sendVerificationEmail', () {
    test('should send verification email', () async {
      final mockUser = MockUser();
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.sendEmailVerification()).thenAnswer((_) async => {});
      await dataSource.sendVerificationEmail();
      verify(mockUser.sendEmailVerification()).called(1);
    });
  });

  group('updateVerificationStatus', () {
    test('should update isVerified in firestore', () async {
      final mockUser = MockUser();
      final mockDocRef = MockDocumentReference();
      final mockCollection = MockCollectionReference();
      when(mockAuth.currentUser).thenReturn(mockUser);
      when(mockUser.reload()).thenAnswer((_) async => {});
      when(mockUser.uid).thenReturn('123');
      when(mockUser.emailVerified).thenReturn(true);
      when(
        mockFirestore.collection('users'),
      ).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
      when(mockCollection.doc('123')).thenReturn(mockDocRef);
      when(mockDocRef.update({'isVerified': true})).thenAnswer((_) async => {});
      await dataSource.updateVerificationStatus();
      verify(mockDocRef.update({'isVerified': true})).called(1);
    });
  });

  group('user', () {
    test('should return userChanges stream', () async {
      when(mockAuth.userChanges()).thenAnswer((_) => const Stream.empty());
      final stream = dataSource.user;
      expect(stream, isA<Stream<User?>>());
    });
  });
}
