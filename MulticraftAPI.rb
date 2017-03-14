require 'net/http'
require 'openssl'
require 'json'

# TODO Add Logger for output
# TODO help text for repl
class MulticraftAPI
  attr_accessor :api_uri, :api_user, :api_key, :return_data
  @api_uri # Not thread safe, is shared between functions
  @api_user
  @api_key
  @return_data # Return resp_parsed['data'] or something more tailored

  def initialize(mc_api, mc_user, mc_key)
    @api_uri = URI.parse(mc_api)
    @api_user = mc_user
    @api_key = mc_key
    @return_data = false
    #TODO a test connection to the API endpoint
  end

  # Command line interface to test API
  # TODO completions, history
  # ex. > listUsers()
  # ex. > getUserId('admin')
  # ex. > updateUser(10, {})
  # ex. > updateUser    ( 10  , {}   )
  # ex. > getUserId('admin', {'server_name': 'niflheim', 'id': }, 15)
  def repl
    while (true) do
      # Get input
      print "#{@api_user}@api> "
      STDOUT.flush
      inp = gets.chomp!
      args_start = inp.index('(') || inp.length
      args_end = inp.index(')', -1) || inp.length
      command = inp[0...args_start].strip
      # Process command and print result
      case command
      when ''
        next
      when "exit", "quit"
        puts strings(:exit)
        break
      when "help", "h"
        puts strings(:help)
        next
      else # Try to process as an actual API command
        # Check command validity
        if command_valid?(command)
          args_str = inp[args_start+1...args_end] # May be empty
          begin
            args = eval("[#{args_str}]")
          rescue StandardError => e
            puts strings(:invalid_arguments)
            # raise e
            next
          end
          begin
            resp = self.send(command, *args)
          rescue StandardError => e
            puts strings(:invalid_command, command, args)
            # raise e
            next
          end
          puts resp
        else
          puts strings(:invalid_command, command)
          next
        end

      end
    end
  end
  # Take string of function arguments and return array of arguments
  # arguments may be: normal (int, string usually), hash
  # def args_parse(args_str)
  #     delimiters = ['{', '}', '"', '"'] # ['(', '[', '{', '"', "'", ')', ']', '}']
  #     stack = []
  #     last_delimiter = ''
  #     in_hash = false
  #     args = []
  #     # Treat top level hashes as a string. Parse them as JSON
  #     args_str.split('').each do |c|
  #         # If c matches last_delimiter, pop until last_delimiter and commit to args
  #         if (c == last_delimiter)
  #             popped = ''
  #             data = case last_delimiter
  #             when "'", '"'
  #                 ''
  #             when '['
  #                 []
  #             end
  #             until(popped == last_delimiter) do
  #                 data += popped
  #                 popped = stack.pop
  #             end
  #         end
  #         # Update last_delimiter if !in_hash
  #         stack.push(c)
  #         case c
  #         when '(', '[', '{', '"', "'"
  #         when ')', ']', '}'
  #         else
  #     end
  #     args
  # end
  # TODO move down to private section
  def strings(label, code_0='', code_1='') # codes used for error text
    case label
    when :exit
      'Exiting...'
    when :help
      help_text
    when :invalid_arguments
      "Invalid arguments!"
    when :invalid_command
      "Invalid command! #{code_0}(#{code_1})"
    when :invalid_permissions
    else # Unexpected label
      "UnexpectedLabel(#{label},#{code_0},#{code_1})"
    end
  end
  ###### BEGIN Auto-generated code from php_methods.php with some changes to arg_list naming and returned data. ######
  def listUsers()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def findUsers(arg_list={})
    params = {'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getUser(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getCurrentUser()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def updateUser(id, arg_list={}, send_mail=0)
    params = {'id': id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json, 'send_mail': send_mail}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def createUser(name, email, password, lang='', send_mail=0)
    params = {'name': name, 'email': email, 'password': password, 'lang': lang, 'send_mail': send_mail}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def deleteUser(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getUserRole(user_id, server_id)
    params = {'user_id': user_id, 'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def setUserRole(user_id, server_id, role)
    params = {'user_id': user_id, 'server_id': server_id, 'role': role}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getUserFtpAccess(user_id, server_id)
    params = {'user_id': user_id, 'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def setUserFtpAccess(user_id, server_id, mode)
    params = {'user_id': user_id, 'server_id': server_id, 'mode': mode}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getUserId(name)
    params = {'name': name}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def validateUser(name, password)
    params = {'name': name, 'password': password}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def generateUserApiKey(user_id)
    params = {'user_id': user_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getUserApiKey(user_id)
    params = {'user_id': user_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def removeUserApiKey(user_id)
    params = {'user_id': user_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def listPlayers(server_id)
    params = {'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def findPlayers(server_id, arg_list={})
    params = {'server_id': server_id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getPlayer(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def updatePlayer(id, arg_list={})
    params = {'id': id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def createPlayer(server_id, name, op_command=0)
    params = {'server_id': server_id, 'name': name, 'op_command': op_command}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def deletePlayer(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def assignPlayerToUser(player_id, user_id)
    params = {'player_id': player_id, 'user_id': user_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def listCommands(server_id)
    params = {'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def findCommands(server_id, arg_list={})
    params = {'server_id': server_id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getCommand(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def updateCommand(id, arg_list={})
    params = {'id': id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def createCommand(server_id, name, role, chat, response, run)
    params = {'server_id': server_id, 'name': name, 'role': role, 'chat': chat, 'response': response, 'run': run}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def deleteCommand(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def listServers()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def findServers(arg_list={})
    params = {'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def listServersByConnection(connection_id)
    params = {'connection_id': connection_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def listServersByOwner(user_id)
    params = {'user_id': user_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getServer(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def updateServer(id, arg_list={})
    params = {'id': id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def createServerOn(daemon_id=0, no_commands=0, no_setup_script=0)
    params = {'daemon_id': daemon_id, 'no_commands': no_commands, 'no_setup_script': no_setup_script}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def createServer(name='', port=0, base='', players=0, no_commands=0, no_setup_script=0)
    params = {'name': name, 'port': port, 'base': base, 'players': players, 'no_commands': no_commands, 'no_setup_script': no_setup_script}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def suspendServer(id, stop=1)
    params = {'id': id, 'stop': stop}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def resumeServer(id, start=1)
    params = {'id': id, 'start': start}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def deleteServer(id, delete_dir=no, delete_user=no)
    params = {'id': id, 'delete_dir': delete_dir, 'delete_user': delete_user}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getServerStatus(id, player_list=0)
    params = {'id': id, 'player_list': player_list}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getServerOwner(server_id)
    params = {'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def setServerOwner(server_id, user_id, send_mail=0)
    params = {'server_id': server_id, 'user_id': user_id, 'send_mail': send_mail}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getServerConfig(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def updateServerConfig(id, arg_list={})
    params = {'id': id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def startServerBackup(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getServerBackupStatus(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def startServer(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def stopServer(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def restartServer(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def killServer(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def startAllServers()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def stopAllServers()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def restartAllServers()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def killAllServers()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def sendConsoleCommand(server_id, command)
    params = {'server_id': server_id, 'command': command}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def sendAllConsoleCommand(command)
    params = {'command': command}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def runCommand(server_id, command_id, run_for=0)
    params = {'server_id': server_id, 'command_id': command_id, 'run_for': run_for}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getServerLog(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def clearServerLog(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getServerChat(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def clearServerChat(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def sendServerControl(id, command)
    params = {'id': id, 'command': command}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getServerResources(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def moveServer(server_id, daemon_id)
    params = {'server_id': server_id, 'daemon_id': daemon_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def listConnections()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def findConnections(arg_list={})
    params = {'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getConnection(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def removeConnection(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getConnectionStatus(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getConnectionMemory(id, include_suspended=0)
    params = {'id': id, 'include_suspended': include_suspended}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getStatistics(daemon_id=0, include_suspended=0)
    params = {'daemon_id': daemon_id, 'include_suspended': include_suspended}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def listSettings()
    params = {}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getSetting(key)
    params = {'key': key}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def setSetting(key, value)
    params = {'key': key, 'value': value}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def deleteSetting(key)
    params = {'key': key}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def listSchedules(server_id)
    params = {'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def findSchedules(server_id, arg_list={})
    params = {'server_id': server_id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getSchedule(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def updateSchedule(id, arg_list={})
    params = {'id': id, 'field': arg_list.keys.to_json, 'value': arg_list.values.to_json}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def createSchedule(server_id, name, ts, interval, cmd, status, for_a)
    params = {'server_id': server_id, 'name': name, 'ts': ts, 'interval': interval, 'cmd': cmd, 'status': status, 'for': for_a}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def deleteSchedule(id)
    params = {'id': id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def getDatabaseInfo(server_id)
    params = {'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def createDatabase(server_id)
    params = {'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def changeDatabasePassword(server_id)
    params = {'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def deleteDatabase(server_id)
    params = {'server_id': server_id}
    resp_parsed = api_call(__method__.to_s, params)
  end
  def api_functions
    [
      'listUsers',
      'findUsers',
      'getUser',
      'getCurrentUser',
      'updateUser',
      'createUser',
      'deleteUser',
      'getUserRole',
      'setUserRole',
      'getUserFtpAccess',
      'setUserFtpAccess',
      'getUserId',
      'validateUser',
      'generateUserApiKey',
      'getUserApiKey',
      'removeUserApiKey',
      'listPlayers',
      'findPlayers',
      'getPlayer',
      'updatePlayer',
      'createPlayer',
      'deletePlayer',
      'assignPlayerToUser',
      'listCommands',
      'findCommands',
      'getCommand',
      'updateCommand',
      'createCommand',
      'deleteCommand',
      'listServers',
      'findServers',
      'listServersByConnection',
      'listServersByOwner',
      'getServer',
      'updateServer',
      'createServerOn',
      'createServer',
      'suspendServer',
      'resumeServer',
      'deleteServer',
      'getServerStatus',
      'getServerOwner',
      'setServerOwner',
      'getServerConfig',
      'updateServerConfig',
      'startServerBackup',
      'getServerBackupStatus',
      'startServer',
      'stopServer',
      'restartServer',
      'killServer',
      'startAllServers',
      'stopAllServers',
      'restartAllServers',
      'killAllServers',
      'sendConsoleCommand',
      'sendAllConsoleCommand',
      'runCommand',
      'getServerLog',
      'clearServerLog',
      'getServerChat',
      'clearServerChat',
      'sendServerControl',
      'getServerResources',
      'moveServer',
      'listConnections',
      'findConnections',
      'getConnection',
      'removeConnection',
      'getConnectionStatus',
      'getConnectionMemory',
      'getStatistics',
      'listSettings',
      'getSetting',
      'setSetting',
      'deleteSetting',
      'listSchedules',
      'findSchedules',
      'getSchedule',
      'updateSchedule',
      'createSchedule',
      'deleteSchedule',
      'getDatabaseInfo',
      'createDatabase',
      'changeDatabasePassword',
      'deleteDatabase',
    ]
  end
  ###### END Auto-generated code ######
  protected
  def settings_functions
    [
      'api_uri',
      'api_user',
      'api_key',
      'return_data',
    ]
  end
  def command_valid? (cmd)
    # Only valid when:
    #  - cmd matches one of the available API function names
    #  - cmd matches one of the API setting function names
    if (api_functions.include? cmd)
      true
    elsif (settings_functions.include? cmd)
      true
    else
      false
    end
  end
  # mc_params as a hash of {name: string}
  def api_call(mc_query, mc_params={})
    ret = {}

    temp_params = mc_params.merge!({
                                     '_MulticraftAPIMethod': mc_query,
                                    '_MulticraftAPIUser': @api_user
                                   })
    hmac_data = ''
    temp_params.each do |k, v|
      hmac_data.concat("#{k}#{v}")
    end

    hmac_hash = OpenSSL::HMAC.hexdigest('SHA256', @api_key, hmac_data)
    final_params = temp_params.merge!({'_MulticraftAPIKey': hmac_hash})

    @api_uri.query = URI.encode_www_form(final_params)
    resp = Net::HTTP.get_response(@api_uri)
    @api_uri.query = nil
    resp_parsed = JSON.parse(resp.body)

    # Check response code, return as success, errors, data
    case resp.code
    when 200
      true
    else # Maybe print an error message to console
      false
    end
    # resp_parsed # returns hash {"success": bool, "errors": '', "data": {}}
    APIResponse.new(resp_parsed)
  end
  class APIResponse
    attr_accessor :success, :errors, :data
    def initialize(succ, err, data)
      @success = succ
      @errors = err
      @data = data
    end
    def initialize(hsh)
      @success = hsh['success']
      @errors = hsh['errors']
      @data = hsh['data']
    end
    def to_s
      "{\n  success: #{@success},\n  errors: #{@errors},\n  data: #{@data}\n}"
    end
  end
end

# Test
# mc = MulticraftAPI.new('http://localhost/api.php', 'homepage', '4QHMwZg=m9Zzgc')
# mc.return_data = true
# mc.repl
