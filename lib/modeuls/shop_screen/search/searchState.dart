abstract class SearchStates{}
class SearchIntinalState extends SearchStates{}
class SearchLoadingDataState extends SearchStates {}
class SearchSucessDataState extends SearchStates {}
class SearchFinishDataState extends SearchStates {}
class SearchErrorDataState extends SearchStates {
  final String error;

  SearchErrorDataState(this.error);
}