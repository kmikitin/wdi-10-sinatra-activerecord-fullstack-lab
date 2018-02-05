// check for connection
// console.log('connected')
// $('body').append($('<p>jquery</p>'))

const deleteItem = (itemId) => {
	console.log("you deleted: " + itemId);
	$.ajax({
		url: '/items/j/' + itemId,
		method: 'DELETE',
		dataType: 'JSON',
		success: getItems,
		fail: (err) => {
			console.log(err, 'there was an error in delete')
		}

	})
}

const updateItem = (itemId) => {
	console.log("Item update forthcoming")
	// $.ajax({
	// 	url: '/items/j/' + itemId,
	// 	method: 'PATCH',
	// 	dataType: 'JSON',
	// 	success: 
	// 	fail: (err) => {
	// 		console.log(err, 'there was an error in the update')
	// 	}
	// })
}

const showEditor = (data) => {
	// console.log(data);
	const $items = $("#items li");
	// console.log($items);
	
	// this will hold the item we want
	let which;

	// looping to find where in the form to append to the html
	for(i of $items) {
		// console.log(i);
		let thisIndex = $(i).data('thisitem');
		if (thisIndex== data.item.id) {
			which = i
			break;
		}
	}//end of for loop

	// console.log(which);

	const $theItem = $(which);
	const $form = $('<div>');
	const $input = $('<input type="text" name="title" value="' + data.item.title +'">');
	$form.append($input);
	const $button = $('<button data-action="update">').text('Update Item');
	$form.append($button);
	$theItem.append($form);
}

const editItem = (itemId) => {
	console.log("you edited: " + itemId);

	const title = $('#new-item').val();

	$.ajax({
		url: '/items/j/edit/' + itemId,
		method: 'GET',
		dataType: 'JSON',
		success: showEditor,
		fail: (err) => {
			console.log(err, 'there was an error with the edit ajax call')
		}
	})
}


$('#items').on('click', 'li', (event) => {
	// getting the item #
	const itemId = $(event.currentTarget).data('thisitem');
	// getting the route for the action
	const action = $(event.target).data('action');

	if (action == "delete") deleteItem(itemId);
	else if (action == "edit") editItem(itemId);
	else if (action == "update") updateItem(itemId);
})

// this is creating a new item with the information submitted in the form 
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

