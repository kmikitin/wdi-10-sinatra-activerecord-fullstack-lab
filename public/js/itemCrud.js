// check for connection
// console.log('connected')
// $('body').append($('<p>jquery</p>'))

$('#items').on('click', 'li', (event) => {
	console.log($(event.currentTarget).data('thisitem'));
	console.log($(event.target).data('action'));
})


$('#add-item').on('click', (event) => {

	const title = $('#new-item').val();

	$.ajax({
		url: '/items/j',
		method: 'POST',
		dataType: 'JSON',
		data: {
			title: title
		},
		success: (data) => {
			console.log(data)
			$('#new-item').val("");
			getItems();
		},
		fail: (err) => {
			console.log(err, "post is broke")
		}
	})
})

const getItems = () => {
	$.ajax({
	url: '/items/j',
	method: 'GET',
	dataType: 'JSON',
	success: printResults,
	fail: (err) => {
		console.log(err, 'index/get is broke')
	}
})
}

const printResults = (data) => {
	$('#items').empty()
	// console.log(data)
	const theItems = data.items;
	data.items.forEach((item) => {
		const $item = $('<li data-thisitem="' + item.id + '">');
		$item.text(item.title);
		$item.append($('<button data-action="delete">Delete</button>'));
		$item.append($('<a href="#" data-action="edit">Edit</a>'));
		$('#items').append($item);
	});
}

getItems()

