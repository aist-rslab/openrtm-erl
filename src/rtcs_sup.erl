%%-----------------------------------------------------------------------------
%% @author Geoffrey Biggs <geoffrey.biggs@aist.go.jp>
%% @doc Supervisor for all RT Components in a manager.
%% @reference <a href="http://www.openrtm.org/">OpenRTM.org</a>
%% @copyright 2010 Geoffrey Biggs
%% RT-Synthesis Research Group
%% Intelligent Systems Research Institute,
%% National Institute of Advanced Industrial Science and Technology (AIST),
%% Japan
%% All rights reserved.
%% Licensed under the Eclipse Public License -v 1.0 (EPL)
%% http://www.opensource.org/licenses/eclipse-1.0.txt
%% @version {@version}
%% @end
%%-----------------------------------------------------------------------------
-module(rtcs_sup).
-behaviour(supervisor).


%%-----------------------------------------------------------------------------
%% Include files
%%-----------------------------------------------------------------------------
-include_lib("eunit/include/eunit.hrl").
-include("type_specs.hrl").


%%-----------------------------------------------------------------------------
%% Macros
%%-----------------------------------------------------------------------------


%%-----------------------------------------------------------------------------
%% External exports
%%-----------------------------------------------------------------------------
-export([start_link/0]).


%%-----------------------------------------------------------------------------
%% Internal exports
%%-----------------------------------------------------------------------------
-export([init/1]).


%%=============================================================================
%% External functions
%%=============================================================================

%%-----------------------------------------------------------------------------
%% @doc Start the RTCs supervisor.
%% @spec start_link() ->
%%      {ok, pid()} | ignore | {error, Error}
%% where
%%      Error = {already_started, pid()} | shutdown | any()
%% @end
-spec(start_link() ->
        {ok, pid()} | ignore |
        {error, {already_started, pid()} | shutdown | any()}).
%%-----------------------------------------------------------------------------
start_link() ->
    supervisor:start_link({local, rtcs_sup}, rtcs_sup, []).


%%=============================================================================
%% Internal functions
%%=============================================================================

%%-----------------------------------------------------------------------------
%% @doc Supervisor initialisation callback. See the supervisor documentation
%% for more details.
%% @spec init(Args) -> Result
%% @end
-spec(init(any()) -> sup_init_res()).
%%-----------------------------------------------------------------------------
init(_Args) ->
    {ok, {{simple_one_for_one, 0, 1}, child_spec()}}.


%%-----------------------------------------------------------------------------
%% @doc Defines the child_spec for this supervisor.
%% @spec child_spec() -> ChildSpec
%% @end
-spec(child_spec() -> [child_spec()]).
%%-----------------------------------------------------------------------------
child_spec() ->
    [{rtc_sup, {rtc_sup, start_link, []}, temporary, infinity, supervisor,
            [rtc_sup]}].

%%=============================================================================
%% Test functions
%%=============================================================================
-ifdef(TEST).

%%-----------------------------------------------------------------------------
%% @doc Test the child_spec is syntactically correct.
%% @spec child_spec_test() -> ok
%% @end
-spec(child_spec_test() -> ok).
%%-----------------------------------------------------------------------------
child_spec_test() ->
    ?assertEqual(ok, supervisor:check_childspecs(child_spec())).

-endif. % TEST

