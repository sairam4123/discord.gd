class_name Message

var id: String
var channel_id: String
var guild_id: String
var content: String
var timestamp: String
var edited_timestamp: String
var webhook_id: String
var type: String

var author: User
var member: Dictionary
var activity: Dictionary
var message_reference: Dictionary
var referenced_message: Dictionary

var tts: bool
var mention_everyone: bool
var pinned: bool

var mentions: Array
var mention_roles: Array
var mention_channels: Array
var attachments: Array
var embeds: Array
var reactions: Array

var nonce

var MESSAGE_TYPES = {
	'0': 'DEFAULT',
	'1': 'RECIPIENT_ADD',
	'2': 'RECIPIENT_REMOVE',
	'3': 'CALL',
	'4': 'CHANNEL_NAME_CHANGE',
	'5': 'CHANNEL_ICON_CHANGE',
	'6': 'CHANNEL_PINNED_MESSAGE',
	'7': 'GUILD_MEMBER_JOIN',
	'8': 'USER_PREMIUM_GUILD_SUBSCRIPTION',
	'9': 'USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_1',
	'10': 'USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_2',
	'11': 'USER_PREMIUM_GUILD_SUBSCRIPTION_TIER_3',
	'12': 'CHANNEL_FOLLOW_ADD',
	'14': 'GUILD_DISCOVERY_DISQUALIFIED',
	'15': 'GUILD_DISCOVERY_REQUALIFIED',
	'16': 'GUILD_DISCOVERY_GRACE_PERIOD_INITIAL_WARNING',
	'17': 'GUILD_DISCOVERY_GRACE_PERIOD_FINAL_WARNING',
	'18': 'THREAD_CREATED',
	'19': 'REPLY',
	'20': 'APPLICATION_COMMAND',
	'21': 'THREAD_STARTER_MESSAGE',
	'22': 'GUILD_INVITE_REMINDER'
}

func _init(message: Dictionary):
	# Compulsory
	assert(message.id, 'Message must have an id')
	id = message.id

	assert(message.has('type'), 'Message must have a type')

	assert(message.has('channel_id') and message.channel_id and Helpers.is_valid_str(message.channel_id), 'Message must have a valid channel_id')
	channel_id = message.channel_id

	if MESSAGE_TYPES.get(str(message.type)):
		type = MESSAGE_TYPES.get(str(message.type))
	else:
		assert(false, 'Message must have a valid type')

	assert(message.has('author'), 'Message must have an author')
	# Check if the message is sent by webhook
	if message.has('webhook_id') and Helpers.is_str(message.webhook_id) and message.webhook_id.length() > 0:
		# user sent a webhook
		assert(typeof(message.author) == TYPE_DICTIONARY, 'author attribute of webhook Message must be a Dictionary')
	else:
		# sent by user
		assert(message.author is User, 'author attribute of Mesage must be of type User')
	author = message.author

#	if message.channel.type != 'DM':
#		assert(message.has('guild_id') and message.guild_id and Helpers.is_valid_str(message.guild_id), 'Message must have a valid guild_id')
#		guild_id = message.guild_id

	if message.has('guild_id') and message.guild_id:
		guild_id = message.guild_id

	assert(not (message.content == '' and message.embeds.size() == 0), 'Message must have a content or embed')
	content = message.content

	assert(message.timestamp, 'Message must have a timestamp')
	timestamp = message.timestamp



	# Optional
	if message.has('edited_timestamp') and message.edited_timestamp != null:
		edited_timestamp = message.edited_timestamp

	if message.has('tts'):
		tts = true if message.tts else false

	if message.has('mention_everyone'):
		mention_everyone = true if message.mention_everyone else false

	if message.has('mentions') and typeof(message.mentions) == TYPE_ARRAY and message.mentions.size() > 0:
		mentions = message.mentions

	if message.has('member') and message.member:
		member = message.member
	if message.has('mention_roles') and message.mention_roles:
		mention_roles = message.mention_roles
	if message.has('mention_channels') and message.mention_channels:
		mention_channels = message.mention_channels
	if message.has('attachments') and message.attachments:
		attachments = message.attachments
	if message.has('embeds') and message.embeds:
		embeds = message.embeds
	if message.has('reactions') and message.reactions:
		reactions = message.reactions
	if message.has('pinned') and typeof(message.pinned) == TYPE_BOOL:
		pinned = message.pinned
	if message.has('message_reference') and message.message_reference:
		message_reference = message.message_reference
	if message.has('referenced_message') and message.referenced_message:
		referenced_message = message.referenced_message

func _to_string():
	return JSON.print(
		{
			'id': id,
			'channel_id': channel_id,
			'guild_id': guild_id,
			'author': author,
			'member': member,
			'content': content,
			'timestamp': timestamp,
			'edited_timestamp': edited_timestamp,
			'tts': tts,
			'mention_everyone': mention_everyone,
			'mentions': mentions,
			'mention_roles': mention_roles,
			'mention_channels': mention_channels,
			'attachments': attachments,
			'embeds': embeds,
			'reactions': reactions,
			'pinned': pinned,
			'type': type,
			'message_reference': message_reference,
			'referenced_message': referenced_message
		}
	)

func has(attribute):
	return true if self[attribute] else false